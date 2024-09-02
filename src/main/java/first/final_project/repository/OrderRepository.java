package first.final_project.repository;

import org.springframework.stereotype.Repository;

import first.final_project.vo.Order;

import org.springframework.data.jpa.repository.JpaRepository;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {

    Order findByMerchantUid(String merchantUid);
}
