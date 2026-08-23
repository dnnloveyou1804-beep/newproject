import Foundation

struct Localization {
    static let translations: [AppLanguage: [String: String]] = [
        .english: [
            // Dashboard
            "dashboard_title": "DucNamTweaks",
            "dashboard_tab": "Dashboard",
            "settings_tab": "Settings",
            
            // System Stats
            "battery_level": "Battery",
            "charging": "Charging",
            "discharging": "Unplugged",
            
            // Device Info
            "device_model": "Device",
            "os_version": "OS",
            "storage": "Storage",
            "ram": "RAM",
            "free_of": "free of",
            
            // Profiles
            "active_profile": "Active Configuration",
            "profile_default": "Default",
            "profile_gaming": "Gaming Mode",
            "profile_battery": "Battery Saver",
            
            // Game Booster
            "game_booster": "Game Booster",
            "optimize_play": "Optimize & Play",
            "optimizing": "Injecting Tweaks...",
            "ram_clearing": "Clearing memory...",
            "network_tuning": "Tuning network ping...",
            "launching": "Launching Game...",
            
            // Activation
            "activation_required": "Activation Required",
            "copy_device_id": "Copy Device ID",
            "enter_license_key": "Enter License Key",
            "invalid_key": "Invalid or expired license key.",
            "activate_now": "Activate Now",
            "contact_admin_desc": "Please provide your Device ID to the administrator to receive a valid license key.",
            
            // Tweaks
            "display_refresh_rate": "Display Refresh Rate",
            "refresh_rate_desc": "Adjust screen refresh rate globally to save battery or increase smoothness.",
            
            "performance_profile": "Performance Profile",
            "performance_desc": "System-wide CPU/GPU governor configuration.",
            
            "pointer_speed": "Pointer Speed",
            "pointer_desc": "Adjust connected mouse/trackpad pointer velocity.",
            
            "touch_sensitivity": "Touch Sensitivity",
            "touch_desc": "Hardware level touch panel digitizer sensitivity threshold.",
            
            "input_latency": "Input Latency Offset",
            "latency_desc": "Kernel level input delay compensation in milliseconds.",
            
            "haptic_intensity": "Haptic Engine Power",
            "haptic_desc": "Adjust the physical vibration motor voltage curve.",
            
            "battery_saver": "Ultra Battery Saver",
            "battery_saver_desc": "Aggressively kills background processes and dims screen.",
            
            "app_theme": "App Accent Color",
            "theme_desc": "Change the primary accent color of the admin panel.",
            
            "badge_style": "Notification Badges",
            "badge_desc": "Toggle app icon notification badges system-wide.",
            
            // Detail
            "control_panel": "Control Panel",
            "done": "Done",
            "value": "Value:",
            "read_only": "(Read-only status)",
            
            // Settings
            "settings_title": "Settings",
            "about": "About DucNamTweaks",
            "reset_all": "Reset All Tweaks",
            "reset_confirm_title": "Reset All Tweaks",
            "reset_confirm_msg": "Are you sure you want to reset all tweak preferences to default?",
            "cancel": "Cancel",
            "reset": "Reset",
            
            "language": "Language",
            "appearance": "Appearance",
            "system_default": "System",
            "light": "Light",
            "dark": "Dark",
            "require_faceid": "Require FaceID / Passcode",
            "security": "Security",
            "ui_settings": "Interface",
            
            // About
            "about_title": "About DucNamTweaks",
            "about_desc": "DucNamTweaks Pro is an advanced system administration panel designed for ultimate device control. This tool provides deep access to system parameters.",
            "features_title": "Core Features:",
            "features_list": "• Overclocking & Performance Profiles\n• Hardware Touch & Haptic Control\n• Real-time Theme Engine\n• Deep System Tuning"
        ],
        
        .vietnamese: [
            // Dashboard
            "dashboard_title": "DucNamTweaks",
            "dashboard_tab": "Bảng điều khiển",
            "settings_tab": "Cài đặt",
            
            // System Stats
            "battery_level": "Pin",
            "charging": "Đang sạc",
            "discharging": "Rút sạc",
            
            // Device Info
            "device_model": "Thiết bị",
            "os_version": "Hệ điều hành",
            "storage": "Lưu trữ",
            "ram": "Bộ nhớ RAM",
            "free_of": "trống /",
            
            // Profiles
            "active_profile": "Cấu hình Hoạt động",
            "profile_default": "Mặc định",
            "profile_gaming": "Chế độ Gaming",
            "profile_battery": "Tiết kiệm Pin",
            
            // Game Booster
            "game_booster": "Tối ưu Game",
            "optimize_play": "Tối ưu & Chơi",
            "optimizing": "Đang ép xung...",
            "ram_clearing": "Đang dọn dẹp RAM...",
            "network_tuning": "Giảm độ trễ mạng...",
            "launching": "Đang mở Game...",
            
            // Activation
            "activation_required": "Yêu cầu Kích hoạt",
            "copy_device_id": "Sao chép Mã Thiết Bị",
            "enter_license_key": "Nhập Mã Kích Hoạt (License Key)",
            "invalid_key": "Mã kích hoạt không hợp lệ hoặc đã hết hạn.",
            "activate_now": "Kích Hoạt Ngay",
            "contact_admin_desc": "Vui lòng copy Mã Thiết Bị ở trên và gửi cho Quản trị viên để mua Mã Kích Hoạt bản quyền.",
            
            // Tweaks
            "display_refresh_rate": "Tần số quét màn hình",
            "refresh_rate_desc": "Điều chỉnh tần số quét hệ thống để tiết kiệm pin hoặc tăng độ mượt.",
            
            "performance_profile": "Cấu hình Hiệu năng",
            "performance_desc": "Ép xung và giới hạn sức mạnh CPU/GPU toàn hệ thống.",
            
            "pointer_speed": "Tốc độ con trỏ chuột",
            "pointer_desc": "Tinh chỉnh độ nhạy của chuột và trackpad kết nối ngoài.",
            
            "touch_sensitivity": "Độ nhạy cảm ứng",
            "touch_desc": "Mức độ nhận diện lực chạm ở tầng phần cứng màn hình.",
            
            "input_latency": "Bù trừ độ trễ thao tác",
            "latency_desc": "Điều chỉnh độ trễ tín hiệu thao tác tay (tính bằng mili-giây).",
            
            "haptic_intensity": "Cường độ Rung Haptic",
            "haptic_desc": "Chỉnh điện áp mô-tơ rung vật lý của thiết bị.",
            
            "battery_saver": "Siêu tiết kiệm pin",
            "battery_saver_desc": "Dập tắt triệt để các ứng dụng ngầm và ép xung nhịp cực thấp.",
            
            "app_theme": "Màu nhấn ứng dụng",
            "theme_desc": "Thay đổi màu sắc chủ đạo của bảng điều khiển.",
            
            "badge_style": "Huy hiệu Thông báo",
            "badge_desc": "Tắt/Bật dấu chấm đỏ thông báo trên icon toàn hệ thống.",
            
            // Detail
            "control_panel": "Bảng Điều Khiển",
            "done": "Xong",
            "value": "Giá trị:",
            "read_only": "(Trạng thái Chỉ-đọc)",
            
            // Settings
            "settings_title": "Cài đặt",
            "about": "Giới Thiệu DucNamTweaks",
            "reset_all": "Khôi phục Mặc định",
            "reset_confirm_title": "Khôi phục Tất cả",
            "reset_confirm_msg": "Bạn có chắc chắn muốn xoá toàn bộ cấu hình đã lưu và trở về mặc định không?",
            "cancel": "Huỷ",
            "reset": "Khôi phục",
            
            "language": "Ngôn ngữ",
            "appearance": "Giao diện",
            "system_default": "Hệ thống",
            "light": "Sáng",
            "dark": "Tối",
            "require_faceid": "Yêu cầu FaceID / Mật khẩu",
            "security": "Bảo mật",
            "ui_settings": "Giao diện",
            
            // About
            "about_title": "Giới thiệu DucNamTweaks",
            "about_desc": "DucNamTweaks là bảng điều khiển quản trị hệ thống nâng cao được thiết kế để kiểm soát thiết bị tối đa. Công cụ này cung cấp khả năng can thiệp sâu vào các thông số lõi.",
            "features_title": "Tính năng Cốt lõi:",
            "features_list": "• Ép xung & Tối ưu Cấu hình\n• Can thiệp Cảm ứng & Phản hồi Rung\n• Đổi màu sắc thời gian thực\n• Tinh chỉnh Hệ thống Chuyên sâu"
        ]
    ]
}
