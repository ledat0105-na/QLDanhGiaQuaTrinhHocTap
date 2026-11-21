package vn.quanlythuctap.modules.dangky;

import java.util.List;
import org.springframework.stereotype.Component;
import vn.quanlythuctap.common.ThongTinModule;

@Component
public class DangKyModel {
    public ThongTinModule layThongTin() {
        return new ThongTinModule("Đợt và đăng ký", List.of(
            "Kế hoạch và đợt thực tập",
            "Xét điều kiện",
            "Chi tiết xét điều kiện",
            "Hồ sơ thực tập",
            "Người phụ trách hồ sơ"
        ));
    }
}
