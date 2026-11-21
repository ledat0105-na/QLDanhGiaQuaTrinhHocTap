package vn.quanlythuctap.modules.hocvu;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.quanlythuctap.common.ThongTinModule;

@RestController
public class HocVuController {
    private final HocVuModel model;

    public HocVuController(HocVuModel model) {
        this.model = model;
    }

    @GetMapping("/api/modules/hoc-vu")
    public ThongTinModule layThongTin() {
        return model.layThongTin();
    }
}
