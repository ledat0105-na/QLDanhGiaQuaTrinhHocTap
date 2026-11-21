package vn.quanlythuctap.modules.dangky;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.quanlythuctap.common.ThongTinModule;

@RestController
public class DangKyController {
    private final DangKyModel model;

    public DangKyController(DangKyModel model) {
        this.model = model;
    }

    @GetMapping("/api/modules/dang-ky")
    public ThongTinModule layThongTin() {
        return model.layThongTin();
    }
}
