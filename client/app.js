const modules = [["hoc-vu","Tổ chức và học vụ"],["dang-ky","Đợt và đăng ký"],["van-ban","Văn bản và ký duyệt"],["theo-doi","Theo dõi và đánh giá"]];
const menu = document.querySelector('#menu');
const content = document.querySelector('#noi-dung');
let latest = 0;
for (const [id, label] of modules) {
  const button = document.createElement('button');
  button.textContent = label;
  button.addEventListener('click', async () => {
    const request = ++latest;
    content.textContent = 'Đang tải…';
    try {
      const { hienThi } = await import('/modules/' + id + '/view.js');
      const response = await fetch('/api/modules/' + id);
      if (!response.ok) throw Error('API lỗi');
      const data = await response.json();
      if (request === latest) hienThi(content, data);
    } catch {
      if (request === latest) content.textContent = 'Không tải được dữ liệu.';
    }
  });
  menu.append(button);
}
menu.firstElementChild.click();
