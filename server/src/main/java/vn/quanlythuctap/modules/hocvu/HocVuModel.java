package vn.quanlythuctap.modules.hocvu;

import java.util.List;
import org.springframework.stereotype.Component;
import vn.quanlythuctap.common.ThongTinModule;

@Component
public class HocVuModel {
    public ThongTinModule layThongTin() {
        return new ThongTinModule("Tổ chức và học vụ", List.of(
            "Đơn vị nhà trường",
            "Đơn vị thực tập",
            "Tài khoản",
            "Vai trò theo phạm vi",
            "Sinh viên"
        ));
    }
}
