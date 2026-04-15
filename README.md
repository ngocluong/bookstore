# Bookstore

A full-featured e-commerce bookstore built with Ruby on Rails. Supports user authentication (email and Facebook OAuth), a shopping cart, Stripe payments, book reviews and ratings, full-text search, an admin panel, Redis-backed caching, and async background jobs via Sidekiq.

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Ruby on Rails 4.0.6 |
| Language | Ruby 2.1.0 |
| Database | PostgreSQL |
| Background Jobs | Sidekiq |
| Cache Store | Dalli (Memcached) in production, file store in development |
| Image Hosting | Cloudinary |
| Payments | Stripe |
| Authentication | Devise + OmniAuth (Facebook) |
| Admin Panel | ActiveAdmin |
| Search | PG Search (PostgreSQL full-text) |
| Templating | Slim |
| CSS | Bootstrap (via bootstrap-sass) |
| Web Server | Unicorn (production) |

## Features

- **Book Catalog** — Browse books with configurable pagination (9, 12, 15, or 18 per page)
- **Search** — Full-text search across titles and author names with optional category filtering
- **User Accounts** — Email sign-up/sign-in with confirmation, password reset, and account lockout; Facebook OAuth login
- **Shopping Cart** — Persistent cart with a unique session code; add, update, and remove items
- **Checkout & Payments** — Stripe-powered payment processing at order creation
- **Order History** — Authenticated users can view past orders
- **Reviews & Ratings** — Authenticated users can submit a 1–5 star rating and written review per book
- **Admin Panel** — ActiveAdmin interface at `/admin` for managing books, orders, and admin users
- **Caching** — Page-level and fragment caching with background cache invalidation via Sidekiq workers
- **Async Email** — Devise emails (confirmation, password reset) sent via Sidekiq

## Prerequisites

- Ruby 2.1.0
- PostgreSQL
- Redis (for Sidekiq)
- Memcached (production only, for Dalli)
- Bundler

## Setup

### 1. Clone and install dependencies

```bash
git clone <repo-url>
cd bookstore
bundle install
```

### 2. Configure environment variables

Copy the database example config and fill in your credentials:

```bash
cp config/database.yml.example config/database.yml
```

Create a `.env` file (or set the variables in your environment) with the following keys:

```bash
# Stripe
PUBLISHABLE_KEY=pk_test_...
SECRET_KEY=sk_test_...

# Cloudinary
CLOUDINARY_API_KEY=...
CLOUDINARY_API_SECRET=...

# reCAPTCHA
CAPTCHA_PUBLIC_KEY=...
CAPTCHA_PRIVATE_KEY=...
```

For Facebook OAuth, add your app credentials to `config/initializers/devise.rb`.

### 3. Set up the database

```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed        # Seeds 20 sample books and 5 categories
```

### 4. Start the application

**Development** — run each process in a separate terminal:

```bash
# Rails server
bundle exec rails server

# Sidekiq (background jobs & async email)
bundle exec sidekiq
```

Or use Foreman to start everything at once:

```bash
bundle exec foreman start
```

**Production** — Unicorn is configured in `config/unicorn.rb`:

```bash
bundle exec unicorn -p $PORT -E $RACK_ENV -c ./config/unicorn.rb
```

## Testing

The test suite uses RSpec and Cucumber with coverage via SimpleCov.

```bash
# Unit and integration specs
bundle exec rspec

# Acceptance tests
bundle exec cucumber
```

Coverage reports are written to the `coverage/` directory.

## Data Models

```
User         has_many :comments, :orders
Book         has_many :line_items, :comments, :categories (through category_books)
Comment      belongs_to :user, :book  (stores rating 1–5 and content)
Cart         has_many :line_items
LineItem     belongs_to :book, :cart, :order
Order        has_many :line_items; belongs_to :user
Category     has_many :books (through category_books)
AdminUser    Devise-based admin authentication
```

## Key Routes

| Method | Path | Description |
|---|---|---|
| GET | `/` | Redirects to book index |
| GET | `/books` | Paginated book listing |
| GET | `/books/:id` | Book detail with reviews |
| GET | `/search` | Full-text search with category filter |
| GET | `/carts/:id` | Shopping cart |
| POST | `/line_items` | Add book to cart |
| PATCH | `/line_items/:id` | Update item quantity |
| DELETE | `/line_items/:id` | Remove item from cart |
| GET | `/orders` | User order history |
| GET | `/orders/new` | Checkout page |
| POST | `/orders` | Create order (Stripe charge) |
| POST | `/comments` | Submit a review |
| `*` | `/admin` | ActiveAdmin panel |

## Project Structure

```
app/
  controllers/    # BooksController, CartsController, OrdersController, ...
  models/         # Book, User, Cart, Order, Comment, ...
  service/        # Service objects (Order::Calculator, Book::IndexCachier, ...)
  workers/        # ClearCacheWorker, ClearListCacheWorker
  views/          # Slim templates
config/
  routes.rb
  initializers/   # Stripe, Cloudinary, reCAPTCHA, Devise
```

## Deployment

The app is configured for Heroku (`rails_12factor` gem). Ensure the following add-ons or external services are provisioned:

- PostgreSQL
- Redis (Sidekiq)
- Memcached (Dalli)
- Cloudinary
- Stripe account keys
