
if XiStaticPagesWorker::Application === Rails.application
  XiStaticPagesWorker::Application.config.secret_token = 'ab3f5b2749315455862455ded2a55aa5e5a5a8293937cbfe3d70ab1aeb501d94368d2f7ae782d0ae92f283b57069f6d46b5e1174cd0813eb2c024694d07cc0b5'
  XiStaticPagesWorker::Application.config.session_store :cookie_store, :key => '_xi_static_pages_worker_session'
end
