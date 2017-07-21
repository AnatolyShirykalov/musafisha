admin_pw = Rails.application.secrets.admin_pw
User.destroy_all
User.create!(email: 'admin@musafisha.ru', password: admin_pw, password_confirmation: admin_pw)

Page.destroy_all
Menu.destroy_all
h = Menu.create(name: 'Главное', text_slug: 'main').id
p = Page.create!(name: 'Главная', fullpath: '/', menu_ids: [h])
p = Page.create!(name: 'Концерты', fullpath: '/concerts', menu_ids: [h])
