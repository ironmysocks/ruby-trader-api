# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create user with portfolio and three watchlists
user = User.create(first_name:'margo',last_name:'baxter',email:'margo@margo.com',password:'margomargo')

Portfolio.create(user_id: user.id, stocks_attributes: [
  {symbol:'STM',alert_price:'16.00',target_entry:'16.05',target_exit:'19.98',target_stop:'15.50',risk_amount:'0.55',reward_amount:'3.93',
    entry_price:'16.31',entry_date:'2017-05-02 10:30:00',shares:'300'},
  {symbol:'EXAS',alert_price:'29.95',target_entry:'30.01',target_exit:'35.00',target_stop:'29.00',risk_amount:'1.01',reward_amount:'4.99',
    entry_price:'30.54',entry_date:'2017-05-01 10:31:00',shares:'100'}
])
Watchlist.create(user_id: user.id, name:'IoT Sensors', stocks_attributes: [
  {symbol:'INVN',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'MVIS',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'}
])
Watchlist.create(user_id: user.id, name:'IoT Hardware', stocks_attributes: [
  {symbol:'AMD',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'NVDA',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'MU',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'INTC',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'IBM',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'}
])
Watchlist.create(user_id: user.id, name:'IoT Infrastructure', stocks_attributes: [
  {symbol:'AMZN',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'T',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'VZ',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'TMUS',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'},
  {symbol:'GOOG',alert_price:'14.95',target_entry:'15.00',target_exit:'18.00',target_stop:'14.50',risk_amount:'0.50',reward_amount:'3.00'}
])
