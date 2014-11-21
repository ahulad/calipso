module ApplicationHelper

  def full_title(page_title)
    base_title="income/expense tracking"
    base_title+= " | #{page_title}" unless page_title.empty?
  else
    "#{base_title}"
  end


  def count_summ_oper
    [current_user.incexp.where(typef: 0).sum("price"),
     current_user.incexp.where(typef: 1).sum("price")]
  end

  def count_summ_oper_ex(s_start_ex, s_stop_ex, comm_cat)
    [current_user.incexp.where(typef: 0).where("(incexps.datefinans BETWEEN  ? AND ?) AND (#{comm_cat})", s_start_ex, s_stop_ex).sum("price"),
     current_user.incexp.where(typef: 1).where("(incexps.datefinans BETWEEN  ? AND ?) AND (#{comm_cat})", s_start_ex, s_stop_ex).sum("price")]
  end
end