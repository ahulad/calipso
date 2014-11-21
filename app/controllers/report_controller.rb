class ReportController < ApplicationController
  before_filter :authenticate_user!

  include ApplicationHelper

  def report
    @s_start=@s_stop=@categ=""
    if (params[:fromd].nil? && params[:tod].nil?)
      cur_timer=Time.now
      @s_start=DateTime.strptime(cur_timer.to_s, '%Y-%m-%d').strftime("%m/%d/%Y")
      @s_stop=DateTime.strptime((cur_timer+(86400*30)).to_s, '%Y-%m-%d').strftime("%m/%d/%Y")
    else
      @s_start=params[:fromd]
      @s_stop=params[:tod]
      @s_cat=params[:cityid]
      if !(@s_start =~ /^([\d+])+\/+([\d+])+\/+([\d+])+$/) || !(@s_stop =~ /^([\d+])+\/+([\d+])+\/+([\d+])+$/)
        flash[:error] = "Error: format date M/D/Y!"
      else
        @s_start_ex="#{@s_start.split("/")[2]}-#{@s_start.split("/")[0]}-#{@s_start.split("/")[1]} 00:00:00"
        @s_stop_ex="#{@s_stop.split("/")[2]}-#{@s_stop.split("/")[0]}-#{@s_stop.split("/")[1]} 23:59:59"
        case @s_cat.to_i
          when -3
            @comm_cat="true" #ALL
          when -2
            @comm_cat="incexps.typef=1" #ALL e
          when -1
            @comm_cat="incexps.typef!=1" #ALL i
          else
            @comm_cat="incexps.categoty_id=#{@s_cat.to_i}" #CAT i
        end
        @tableout=count_summ_oper_ex(@s_start_ex, @s_stop_ex, @comm_cat)
        @incexps = current_user.incexp.where("(incexps.datefinans BETWEEN  ? AND ?) AND (#{@comm_cat})", @s_start_ex, @s_stop_ex).all.order('id DESC')
        @category = current_user.category.all
        @hash_cat={}
        @category.each do |item|
          @hash_cat[item.id]=item.name
        end
      end
    end
    @sel_opt=[['All', -3], ['All Income', -2], ['All Expense', -1]]
    @category = current_user.category.order('typef DESC').all
    v=3
    @category.each do |item|
      item.typef==1 ? tupf='income' : tupf='expense'
      @sel_opt[v]=["#{item.name} - (#{tupf})", item.id]
      v+=1
    end
  end

end
