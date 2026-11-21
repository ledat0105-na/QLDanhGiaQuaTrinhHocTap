package vn.quanlythuctap.modules.vanban;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.quanlythuctap.common.ThongTinModule;

@RestController
public class VanBanController {
    private final VanBanModel model;

    public VanBanController(VanBanModel model) {
        this.model = model;
    }

    @GetMapping("/api/modules/van-ban")
    public ThongTinModule layThongTin() {
        return model.layThongTin();
    }
}
