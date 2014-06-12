Feature: Show book detail
As an unauthorized user
I want to show details of one book

Background:
  Given The Bookstore has books

Scenario: Show book detail
  When I show book of one book
  Then I will see this book details



