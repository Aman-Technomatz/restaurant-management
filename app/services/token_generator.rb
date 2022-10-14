class TokenGenerator
  @@token = 0
  @@beginning_of_day = Time.now.beginning_of_day
  @@end_of_day = Time.now.end_of_day

  def self.call
    new.call
  end

  def call
    if Time.now.between?( @@beginning_of_day, @@end_of_day )
       @@token += 1
    else
      # reset class variables
      @@token = 1
      @@beginning_of_day = Time.now.beginning_of_day
      @@end_of_day = Time.now.end_of_day
    end
  end
end