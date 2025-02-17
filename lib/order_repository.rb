require_relative './order'

class OrderRepository
    def all
        sql = 'SELECT id, customer, date, item_id FROM orders;'
        result_set = DatabaseConnection.exec_params(sql, [])

        orders = []

        result_set.each do |record|
            order = Order.new
            order.id = record['id']
            order.customer = record['customer']
            order.date = record['date']
            order.item_id = record['item_id']
            
            orders << order
        end

        return orders
    end

    def create(order)
        sql = 'INSERT INTO orders (customer, date, item_id) VALUES($1, $2, $3);'
        sql_params = [order.customer, order.date, order.item_id]

        DatabaseConnection.exec_params(sql, sql_params)
    end
end