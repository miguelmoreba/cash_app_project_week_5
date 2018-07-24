
  def nice_date(date)
    year = date[0]
    month = date[5]
    day = date[8]
    # day = 12
    # month = 3
    # year = 1998
    return "#{day}/#{month}/#{year}"
  end
