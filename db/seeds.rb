admin_pw = Rails.application.secrets.admin_pw
User.destroy_all
User.create!(email: 'admin@musafisha.ru', password: admin_pw, password_confirmation: admin_pw, role: 'admin')

Page.destroy_all
Menu.destroy_all
am = Menu.create!(name: 'Админ', text_slug: 'adminus').id
cm = Menu.create!(name: 'Пользователь', text_slug: 'common').id
un = Menu.create!(name: 'Неавторизванный', text_slug: 'unauthorized').id

Page.create! name: 'Войти', fullpath: '/users/sign_in', menu_ids: [un]
Page.create! name: 'Выйти', fullpath: '/users/sign_out', menu_ids: [am, cm]
Page.create! name: 'Админка', fullpath: '/admin', menu_ids: [am]
