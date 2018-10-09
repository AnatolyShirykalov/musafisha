#100.times {puts 'Ты идиот, это уже запущенный проект'}
admin_pw = '123321'
User.destroy_all
User.create!(name: "Admin", slug: "admin1", email: 'admin@musafisha.ru', password: admin_pw, password_confirmation: admin_pw, role: 'admin')

City.create!(name: "Москва")

Page.destroy_all
Menu.destroy_all
am = Menu.create!(name: 'Админ', text_slug: 'adminus').id
cm = Menu.create!(name: 'Пользователь', text_slug: 'common').id
un = Menu.create!(name: 'Неавторизванный', text_slug: 'unauthorized').id

Page.create! name: 'Войти', fullpath: '/users/sign_in', menu_ids: [un]
Page.create! name: 'Выйти', fullpath: '/users/sign_out', menu_ids: [am, cm]
Page.create! name: 'Админка', fullpath: '/admin', menu_ids: [am]
