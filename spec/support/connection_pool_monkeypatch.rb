# TODO: This is a valiant effort to make this strategy work in Rails 5,
# but it seems to cause some deadlock errors in test.
# Fix or remove before finishing Rails 5 upgrade!

# # Monkey-patch to force single DB connection even in multithreaded
# #   tests (selenium/capybara-webkit/poltergeist)
# ActiveRecord::ConnectionAdapters::ConnectionPool.class_eval do
#   def connection_cache_key(thread)
#     Thread.main.object_id
#   end
# end