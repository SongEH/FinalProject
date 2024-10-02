package first.final_project.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import first.final_project.dao.CommissionMapper;
import first.final_project.util.MyCommon;
import first.final_project.util.Paging;
import first.final_project.vo.CommissionVo;

@Service
public class CommissionService {

    private final CommissionMapper commissionMapper;

    public CommissionService(CommissionMapper commissionMapper) {
        this.commissionMapper = commissionMapper;
    }

    public Map<String, Object> getPagedDeliveries(int raiders_id, int page) {

        int blockList = MyCommon.Commission.BLOCK_LIST;

        int blockPage = MyCommon.Commission.BLOCK_PAGE;

        int rowTotal = commissionMapper.getTotalCount(raiders_id);

        int totalPage = (rowTotal + blockList - 1) / blockList;

        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        int offset = (page - 1) * blockList;
        if (offset < 0) {
            offset = 0; // Prevent negative offset
        }

        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("offset", offset);
        params.put("blockList", blockList);

        List<CommissionVo> deliveries = commissionMapper.selectPageList(params);

        String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page, rowTotal, blockList, blockPage);

        double totalCommission = commissionMapper.selectTotalCommission(raiders_id);

        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries);
        result.put("totalCommission", totalCommission);
        result.put("pageMenu", pageMenu);

        return result;
    }

    public Map<String, Object> getPagedDeliveries(int raiders_id, int page, String startDate, String endDate) {

        if (startDate == null || startDate.isEmpty()) {
            startDate = "2023-01-01";
        }
        if (endDate == null || endDate.isEmpty()) {
            endDate = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE) + " 23:59:59";
        } else {
            // endDate가 주어졌을 때 마지막 시간으로 설정
            endDate = LocalDate.parse(endDate).format(DateTimeFormatter.ISO_LOCAL_DATE) + " 23:59:59";
        }

        int blockList = MyCommon.Commission.BLOCK_LIST;
        int blockPage = MyCommon.Commission.BLOCK_PAGE;
        int rowTotal = commissionMapper.getTotalCountByDate(raiders_id, startDate, endDate);
        int totalPage = (rowTotal + blockList - 1) / blockList;

        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        int offset = (page - 1) * blockList;
        if (offset < 0) {
            offset = 0;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("offset", offset);
        params.put("blockList", blockList);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        List<CommissionVo> deliveries = commissionMapper.selectPageListByDate(params);
        String pageMenu = Paging.getPaging(
                "list.do?raiders_id=" + raiders_id + "&startDate=" + startDate + "&endDate=" + endDate,
                page, rowTotal, blockList, blockPage);
        double totalCommission = commissionMapper.selectTotalCommissionByDate(raiders_id, startDate, endDate);

        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries);
        result.put("totalCommission", totalCommission);
        result.put("pageMenu", pageMenu);

        return result;
    }
}