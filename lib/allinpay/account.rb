###
#  财务接口
#  1. 账户充值
#
###

module Allinpay
  module Account
    extend ActiveSupport::Concern
    included do

      # 账户充值接口
      #
      # Paramters:
      #
      # bank_account 银行账户
      # amount 充值金额
      # business_code 业务代码 默认 100005
      # options 
      #   summary 网银交易备注
      #   remark 商户交易备注
      
      def charge(bank_account, amount, business_code = '100005', options = {})
        params = set_infomation('300006',{ REQTIME: timestamps, LEVEL: 9 })
        charge_info = { 
          BUSINESS_CODE: business_code,
          BANKACCT: bank_account,
          AMOUNT: amount
        }
        charge_info[:SUMMARY] = options[:summary] if options[:summary]
        charge_info[:REMARK] = options[:remark] if options[:remark]
        params[:CHARGEREQ] = charge_info
        res = conn.request(params)
        return result_wrap(:success, res)
      end
    end
  end
end