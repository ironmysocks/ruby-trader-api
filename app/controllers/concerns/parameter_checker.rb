module ParameterChecker
  extend ActiveSupport::Concern

  def users_allowed_params
    [ :first_name, :last_name, :email, :password, :password_confirmation ]
  end

  def stocks_allowed_params
    [ :id, :symbol, :alert_price, :target_entry, :target_exit, :target_stop,
     :risk_amount, :reward_amount, :entry_price, :entry_date, :shares,
     :exit_price, :exit_date, :realized_pl ]
  end

  def stocks_allowed_params_for_stockholder
    stocks_allowed_params << :_destroy
  end

  def watchlists_allowed_params
    [ :user_id, :name, stocks_attributes: stocks_allowed_params_for_stockholder ]
  end

  def portfolios_allowed_params
    [ :user_id, stocks_attributes: stocks_allowed_params_for_stockholder ]
  end

end
