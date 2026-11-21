export function hienThiDanhSach(container, data) {
  const title = document.createElement('h2');
  title.textContent = data.ten;
  const list = document.createElement('ul');
  for (const bang of data.bang) {
    const item = document.createElement('li');
    item.textContent = bang;
    list.append(item);
  }
  container.replaceChildren(title, list);
}
