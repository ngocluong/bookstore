/*!
 * jQuery Raty - A Star Rating Plugin
 *
 * The MIT License
 *
 * @author  : Washington Botelho
 * @doc     : http://wbotelhos.com/raty
 * @version : 2.6.0
 *
 */

;
(function($) {
  'use strict';

  var methods = {
    init: function(options) {
      return this.each(function() {
        this.self = $(this);

        methods.destroy.call(this.self);

        this.opt = $.extend(true, {}, $.fn.raty.defaults, options);

        methods._adjustCallback.call(this);

        methods._adjustNumber.call(this);

        if (this.opt.starType !== 'img') {
          methods._adjustStarType.call(this);
        }

        methods._adjustPath.call(this);
        methods._createStars.call(this);

        if (this.opt.cancel) {
          methods._createCancel.call(this);
        }

        if (this.opt.precision) {
          methods._adjustPrecision.call(this);
        }

        methods._createrating.call(this);
        methods._apply.call(this, this.opt.rating);
        methods._target.call(this, this.opt.rating);

        if (this.opt.readOnly) {
          methods._lock.call(this);
        } else {
          this.style.cursor = 'pointer';

          methods._binds.call(this);
        }

        this.self.data('options', this.opt);
      });
    },

    _adjustCallback: function() {
      var options = ['number', 'readOnly', 'rating', 'ratingName', 'target'];

      for (var i = 0; i < options.length; i++) {
        if (typeof this.opt[options[i]] === 'function') {
          this.opt[options[i]] = this.opt[options[i]].call(this);
        }
      }
    },

    _adjustNumber: function() {
      this.opt.number = methods._between(this.opt.number, 1, this.opt.numberMax);
    },

    _adjustPath: function() {
      this.opt.path = this.opt.path || '';

      if (this.opt.path && this.opt.path.charAt(this.opt.path.length - 1) !== '/') {
        this.opt.path += '/';
      }
    },

    _adjustPrecision: function() {
      this.opt.half       = true;
      this.opt.targetType = 'rating';
    },

    _adjustStarType: function() {
      this.opt.path = '';

      var replaces = ['cancelOff', 'cancelOn', 'starHalf', 'starOff', 'starOn'];

      for (var i = 0; i < replaces.length; i++) {
        this.opt[replaces[i]] = this.opt[replaces[i]].replace('.', '-');
      }
    },

    _apply: function(rating) {
      methods._fill.call(this, rating);

      if (rating) {
        if (rating > 0) {
          this.rating.val(methods._between(rating, 0, this.opt.number));
        }

        methods._roundStars.call(this, rating);
      }
    },

    _between: function(value, min, max) {
      return Math.min(Math.max(parseFloat(value), min), max);
    },

    _binds: function() {
      if (this.cancel) {
        methods._bindOverCancel.call(this);
        methods._bindClickCancel.call(this);
        methods._bindOutCancel.call(this);
      }

      methods._bindOver.call(this);
      methods._bindClick.call(this);
      methods._bindOut.call(this);
    },

    _bindClick: function() {
      var that = this;

      that.stars.on('click.raty', function(evt) {
        var star = $(this);

        that.rating.val((that.opt.half || that.opt.precision) ? that.self.data('rating') : (this.alt || star.data('alt')));

        if (that.opt.click) {
          that.opt.click.call(that, +that.rating.val(), evt);
        }
      });
    },

    _bindClickCancel: function() {
      var that = this;

      that.cancel.on('click.raty', function(evt) {
        that.rating.removeAttr('value');

        if (that.opt.click) {
          that.opt.click.call(that, null, evt);
        }
      });
    },

    _bindOut: function() {
      var that = this;

      that.self.on('mouseleave.raty', function(evt) {
        var rating = +that.rating.val() || undefined;

        methods._apply.call(that, rating);
        methods._target.call(that, rating, evt);

        if (that.opt.mouseout) {
          that.opt.mouseout.call(that, rating, evt);
        }
      });
    },

    _bindOutCancel: function() {
      var that = this;

      that.cancel.on('mouseleave.raty', function(evt) {
        var icon = that.opt.cancelOff;

        if (that.opt.starType !== 'img') {
          icon = that.opt.cancelClass + ' ' + icon;
        }

        methods._setIcon.call(that, this, icon);

        if (that.opt.mouseout) {
          var rating = +that.rating.val() || undefined;

          that.opt.mouseout.call(that, rating, evt);
        }
      });
    },

    _bindOver: function() {
      var that   = this,
          action = that.opt.half ? 'mousemove.raty' : 'mouseover.raty';

      that.stars.on(action, function(evt) {
        var rating = methods._getratingByPosition.call(that, evt, this);

        methods._fill.call(that, rating);

        if (that.opt.half) {
          methods._roundStars.call(that, rating);

          that.self.data('rating', rating);
        }

        methods._target.call(that, rating, evt);

        if (that.opt.mouseover) {
          that.opt.mouseover.call(that, rating, evt);
        }
      });
    },

    _bindOverCancel: function() {
      var that = this;

      that.cancel.on('mouseover.raty', function(evt) {
        var
          starOff = that.opt.path + that.opt.starOff,
          icon    = that.opt.cancelOn;

        if (that.opt.starType === 'img') {
          that.stars.attr('src', starOff);
        } else {
          icon = that.opt.cancelClass + ' ' + icon;

          that.stars.attr('class', starOff);
        }

        methods._setIcon.call(that, this, icon);
        methods._target.call(that, null, evt);

        if (that.opt.mouseover) {
          that.opt.mouseover.call(that, null);
        }
      });
    },

    _buildratingField: function() {
      return $('<input />', { name: this.opt.ratingName, type: 'hidden' }).appendTo(this);
    },

    _createCancel: function() {
      var icon   = this.opt.path + this.opt.cancelOff,
          cancel = $('<' + this.opt.starType + ' />', { title: this.opt.cancelHint, 'class': this.opt.cancelClass });

      if (this.opt.starType === 'img') {
        cancel.attr({ src: icon, alt: 'x' });
      } else {
        // TODO: use $.data
        cancel.attr('data-alt', 'x').addClass(icon);
      }

      if (this.opt.cancelPlace === 'left') {
        this.self.prepend('&#160;').prepend(cancel);
      } else {
        this.self.append('&#160;').append(cancel);
      }

      this.cancel = cancel;
    },

    _createrating: function() {
      var rating = $(this.opt.targetrating);

      this.rating = rating.length ? rating : methods._buildratingField.call(this);
    },

    _createStars: function() {
      for (var i = 1; i <= this.opt.number; i++) {
        var
          name  = methods._nameForIndex.call(this, i),
          attrs = { alt: i, src: this.opt.path + this.opt[name] };

        if (this.opt.starType !== 'img') {
          attrs = { 'data-alt': i, 'class': attrs.src }; // TODO: use $.data.
        }

        attrs.title = methods._getHint.call(this, i);

        $('<' + this.opt.starType + ' />', attrs).appendTo(this);

        if (this.opt.space) {
          this.self.append(i < this.opt.number ? '&#160;' : '');
        }
      }

      this.stars = this.self.children(this.opt.starType);
    },

    _error: function(message) {
      $(this).text(message);

      $.error(message);
    },

    _fill: function(rating) {
      var hash = 0;

      for (var i = 1; i <= this.stars.length; i++) {
        var
          icon,
          star   = this.stars[i - 1],
          turnOn = methods._turnOn.call(this, i, rating);

        if (this.opt.iconRange && this.opt.iconRange.length > hash) {
          var irange = this.opt.iconRange[hash];

          icon = methods._getRangeIcon.call(this, irange, turnOn);

          if (i <= irange.range) {
            methods._setIcon.call(this, star, icon);
          }

          if (i === irange.range) {
            hash++;
          }
        } else {
          icon = this.opt[turnOn ? 'starOn' : 'starOff'];

          methods._setIcon.call(this, star, icon);
        }
      }
    },

    _getRangeIcon: function(irange, turnOn) {
      return turnOn ? irange.on || this.opt.starOn : irange.off || this.opt.starOff;
    },

    _getratingByPosition: function(evt, icon) {
      var rating = parseInt(icon.alt || icon.getAttribute('data-alt'), 10);

      if (this.opt.half) {
        var
          size    = methods._getSize.call(this),
          percent = parseFloat((evt.pageX - $(icon).offset().left) / size);

        if (this.opt.precision) {
          rating = rating - 1 + percent;
        } else {
          rating = rating - 1 + (percent > 0.5 ? 1 : 0.5);
        }
      }

      return rating;
    },

    _getSize: function() {
      var size;

      if (this.opt.starType === 'img') {
        size = this.stars[0].width;
      } else {
        size = parseFloat(this.stars.eq(0).css('font-size'));
      }

      if (!size) {
        methods._error.call(this, 'Could not be possible get the icon size!');
      }

      return size;
    },

    _turnOn: function(i, rating) {
      return this.opt.single ? (i === rating) : (i <= rating);
    },

    _getHint: function(rating) {
      var hint = this.opt.hints[rating - 1];

      return hint === '' ? '' : hint || rating;
    },

    _lock: function() {
      var rating = parseInt(this.rating.val(), 10), // TODO: 3.1 >> [['1'], ['2'], ['3', '.1', '.2']]
          hint  = rating ? methods._getHint.call(this, rating) : this.opt.noRatedMsg;

      this.style.cursor   = '';
      this.title          = hint;

      this.rating.prop('readonly', true);
      this.stars.prop('title', hint);

      if (this.cancel) {
        this.cancel.hide();
      }

      this.self.data('readonly', true);
    },

    _nameForIndex: function(i) {
      return this.opt.rating && this.opt.rating >= i ? 'starOn' : 'starOff';
    },

    _roundStars: function(rating) {
      var rest = (rating % 1).toFixed(2);

      if (rest > this.opt.round.down) {                      // Up:   [x.76 .. x.99]
        var name = 'starOn';

        if (this.opt.halfShow && rest < this.opt.round.up) { // Half: [x.26 .. x.75]
          name = 'starHalf';
        } else if (rest < this.opt.round.full) {             // Down: [x.00 .. x.5]
          name = 'starOff';
        }

        var
          icon = this.opt[name],
          star = this.stars[Math.ceil(rating) - 1];

        methods._setIcon.call(this, star, icon);
      }                                                      // Full down: [x.00 .. x.25]
    },

    _setIcon: function(star, icon) {
      star[this.opt.starType === 'img' ? 'src' : 'className'] = this.opt.path + icon;
    },

    _setTarget: function(target, rating) {
      if (rating) {
        rating = this.opt.targetFormat.toString().replace('{rating}', rating);
      }

      if (target.is(':input')) {
        target.val(rating);
      } else {
        target.html(rating);
      }
    },

    _target: function(rating, evt) {
      if (this.opt.target) {
        var target = $(this.opt.target);

        if (!target.length) {
          methods._error.call(this, 'Target selector invalid or missing!');
        }

        var mouseover = evt && evt.type === 'mouseover';

        if (rating === undefined) {
          rating = this.opt.targetText;
        } else if (rating === null) {
          rating = mouseover ? this.opt.cancelHint : this.opt.targetText;
        } else {
          if (this.opt.targetType === 'hint') {
            rating = methods._getHint.call(this, Math.ceil(rating));
          } else if (this.opt.precision) {
            rating = parseFloat(rating).toFixed(1);
          }

          var mousemove = evt && evt.type === 'mousemove';

          if (!mouseover && !mousemove && !this.opt.targetKeep) {
            rating = this.opt.targetText;
          }
        }

        methods._setTarget.call(this, target, rating);
      }
    },

    _unlock: function() {
      this.style.cursor = 'pointer';
      this.removeAttribute('title');

      this.rating.removeAttr('readonly');

      this.self.data('readonly', false);

      for (var i = 0; i < this.opt.number; i++) {
        this.stars[i].title = methods._getHint.call(this, i + 1);
      }

      if (this.cancel) {
        this.cancel.css('display', '');
      }
    },

    cancel: function(click) {
      return this.each(function() {
        var el = $(this);

        if (el.data('readonly') !== true) {
          methods[click ? 'click' : 'rating'].call(el, null);

          this.rating.removeAttr('value');
        }
      });
    },

    click: function(rating) {
      return this.each(function() {
        if ($(this).data('readonly') !== true) {
          methods._apply.call(this, rating);

          if (this.opt.click) {
            this.opt.click.call(this, rating, $.Event('click'));
          }

          methods._target.call(this, rating);
        }
      });
    },

    destroy: function() {
      return this.each(function() {
        var self = $(this),
            raw  = self.data('raw');

        if (raw) {
          self.off('.raty').empty().css({ cursor: raw.style.cursor }).removeData('readonly');
        } else {
          self.data('raw', self.clone()[0]);
        }
      });
    },

    getrating: function() {
      var rating = [],
          value ;

      this.each(function() {
        value = this.rating.val();

        rating.push(value ? +value : undefined);
      });

      return (rating.length > 1) ? rating : rating[0];
    },

    move: function(rating) {
      return this.each(function() {
        var
          integer  = parseInt(rating, 10),
          opt      = $(this).data('options'),
          decimal  = (+rating).toFixed(1).split('.')[1];

        if (integer >= opt.number) {
          integer = opt.number - 1;
          decimal = 10;
        }

        var
          size    = methods._getSize.call(this),
          point   = size / 10,
          star    = $(this.stars[integer]),
          percent = star.offset().left + point * parseInt(decimal, 10),
          evt     = $.Event('mousemove', { pageX: percent });

        star.trigger(evt);
      });
    },

    readOnly: function(readonly) {
      return this.each(function() {
        var self = $(this);

        if (self.data('readonly') !== readonly) {
          if (readonly) {
            self.off('.raty').children('img').off('.raty');

            methods._lock.call(this);
          } else {
            methods._binds.call(this);
            methods._unlock.call(this);
          }

          self.data('readonly', readonly);
        }
      });
    },

    reload: function() {
      return methods.set.call(this, {});
    },

    rating: function() {
      var self = $(this);

      return arguments.length ? methods.setrating.apply(self, arguments) : methods.getrating.call(self);
    },

    set: function(options) {
      return this.each(function() {
        var self   = $(this),
            actual = self.data('options'),
            news   = $.extend({}, actual, options);

        self.raty(news);
      });
    },

    setrating: function(rating) {
      return this.each(function() {
        if ($(this).data('readonly') !== true) {
          methods._apply.call(this, rating);
          methods._target.call(this, rating);
        }
      });
    }
  };

  $.fn.raty = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + method + ' does not exist!');
    }
  };

  $.fn.raty.defaults = {
    cancel       : false,
    cancelClass  : 'raty-cancel',
    cancelHint   : 'Cancel this rating!',
    cancelOff    : 'cancel-off.png',
    cancelOn     : 'cancel-on.png',
    cancelPlace  : 'left',
    click        : undefined,
    half         : false,
    halfShow     : true,
    hints        : ['bad', 'poor', 'regular', 'good', 'gorgeous'],
    iconRange    : undefined,
    mouseout     : undefined,
    mouseover    : undefined,
    noRatedMsg   : 'Not rated yet!',
    number       : 5,
    numberMax    : 20,
    path         : undefined,
    precision    : false,
    readOnly     : false,
    round        : { down: 0.25, full: 0.6, up: 0.76 },
    rating        : undefined,
    ratingName    : 'rating',
    single       : false,
    space        : true,
    starHalf     : 'star-half.png',
    starOff      : '/assets/star-off.png',
    starOn       : '/assets/star-on.png',
    starType     : 'img',
    target       : undefined,
    targetFormat : '{rating}',
    targetKeep   : false,
    targetrating  : undefined,
    targetText   : '',
    targetType   : 'hint'
  };

})(jQuery);
