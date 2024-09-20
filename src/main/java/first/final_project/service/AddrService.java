package first.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.final_project.dao.AddrMapper;
import first.final_project.vo.AddrVo;

@Service
public class AddrService {

    @Autowired
    private AddrMapper addrMapper;

    public AddrVo getAddressByMemberId(int memberId) {
        return addrMapper.selectOneFromIdx(memberId);
    }
}
