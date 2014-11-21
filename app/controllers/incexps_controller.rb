class IncexpsController < ApplicationController
  before_filter :authenticate_user!
  include ApplicationHelper


  def edit
    @operation = current_user.incexp.find(params[:id])
  end


  def update
    oper = current_user.incexp.find(params[:id])
    oper.update(oper_params2) ? flash[:success] = "operation update!" : flash[:error] = "ERROR!"
    redirect_to incexps_path
  end

  def destroy
    incexp = current_user.incexp.find(params[:id])
    incexp.destroy ? flash[:success] = "operation deleted!" : flash[:error] = "ERROR!"
    redirect_to incexps_path
  end

  def index

    @category = current_user.category.all
    @hash_cat={}
    @category.each do |item|
      @hash_cat[item.id]=item.name
    end
    @tableout=count_summ_oper
    @incexps = current_user.incexp.paginate(page: params[:page], :per_page => 24).order('id DESC')
  end


  def new
    if (params[:t].to_i==1)
      @cat_type=1
    else
      @cat_type=0
    end
    @category = current_user.category.where(typef: @cat_type).all
    @category_ex=[]
    v=0
    @category.each do |item|
      @category_ex[v]=[item.name, item.id]
      v+=1
    end
    @operation = Incexp.new
  end


  def create
    if  !(params[:incexp][:datefinans] =~ /^([\d+])+\/+([\d+])+\/+([\d+])+$/)
      flash[:error] = "Error: format date M/D/Y!"
      redirect_to incexps_path
    else
      if params[:incexp][:categoty_id].nil?
        flash[:error] = "Error: setup category!"
        redirect_to incexps_path
      else
        @operation= current_user.incexp.build(oper_params)
        if @operation.save
          flash[:success] = "operation created!"
          redirect_to incexps_path
        else
          flash[:error] = "ERROR!"
          redirect_to incexps_path
        end
      end
    end

  end


  def oper_params2
    params.require(:incexp).permit(:name, :price)
  end


  def oper_params
    params[:incexp][:datefinans]="#{params[:incexp][:datefinans].split("/")[1]}/#{params[:incexp][:datefinans].split("/")[0]}/#{params[:incexp][:datefinans].split("/")[2]}"
    params.require(:incexp).permit(:name, :typef, :categoty_id, :price, :datefinans)
  end
end
