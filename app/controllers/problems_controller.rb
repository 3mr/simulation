class ProblemsController < ApplicationController
  def index
    @customers_count = 100

    @customers = []
    @arrival_time = 0
    @last_time_service_ends = 0

    @total = {inter_arrival_time: 0, service_time: 0, waiting_in_queue: 0, time_in_system: 0, server_idel_time: 0, customers_who_wait: 0}
    @customers_count.times do |i|
      customer = {}
      customer[:number] = i + 1

      customer[:inter_arrival_time] = (i == 0) ? 0 : calculate_inetr_arrival_time(rand(0...1.0))
      @total[:inter_arrival_time] += customer[:inter_arrival_time]

      @arrival_time += customer[:inter_arrival_time]
      customer[:arrival_time] = @arrival_time

      customer[:service_time] = calculate_service_time(rand(0...1.0))
      @total[:service_time] += customer[:service_time]

      customer[:time_service_begins] = [@last_time_service_ends, @arrival_time].max
      customer[:time_service_ends] = customer[:time_service_begins] + customer[:service_time]

      customer[:waiting_in_queue] = customer[:time_service_begins] - @arrival_time
      @total[:waiting_in_queue] += customer[:waiting_in_queue]
      @total[:customers_who_wait] += 1 if customer[:waiting_in_queue] > 0

      customer[:time_in_system] = customer[:time_service_ends] - customer[:arrival_time]
      @total[:time_in_system] += customer[:time_in_system]

      customer[:server_idel_time] = customer[:time_service_begins] - @last_time_service_ends
      @total[:server_idel_time] += customer[:server_idel_time]

      @customers << customer

      # update this var to hold the latest value
      @last_time_service_ends = customer[:time_service_ends]
    end
  end

  def calculate_inetr_arrival_time random_number
    case
    when random_number < 0.125
      @inter_arrival = 1
    when 0.125 <= random_number && random_number < 0.25
      @inter_arrival = 2
    when 0.25 <= random_number && random_number < 0.375
      @inter_arrival = 3
    when 0.375 <= random_number && random_number < 0.5
      @inter_arrival = 4
    when 0.5 <= random_number && random_number < 0.625
      @inter_arrival = 5
    when 0.625 <= random_number && random_number < 0.75
      @inter_arrival = 6
    when 0.75 <= random_number && random_number < 0.875
      @inter_arrival = 7
    else
      @inter_arrival = 8
    end
  end

  def calculate_service_time random_number
    case
    when random_number < 0.1
      @service_time = 1
    when 0.1 <= random_number && random_number < 0.3
      @service_time = 2
    when 0.3 <= random_number && random_number < 0.6
      @service_time = 3
    when 0.6 <= random_number && random_number < 0.85
      @service_time = 4
    when 0.85 <= random_number && random_number < 0.95
      @service_time = 5
    else
      @service_time = 6
    end
  end
end
