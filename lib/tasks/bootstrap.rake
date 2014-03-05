namespace :bootstrap do
    desc "Add a single admin to the site"
    task :initial_admin => :environment do
        admin = Member.create(
            first_name: "Default",
            last_name: "Admin",
            case_id: "dxa",
            email: "andrew.mason598@gmail.com",
            password: Member.random_password,
            year: "Freshman",
            competitive: false,
            officer: true,
            position: "Treasurer")
=begin
        Member.create(
            first_name: "Andrew",
            last_name: "Mason",
            case_id: "ajm188",
            email: "ajm188@case.edu",
            password: Member.random_password,
            year: "Sophomore",
            competitive: true,
            officer: true,
            position: "Vice President")
=end
        MemberMailer.welcome_email(admin).deliver
    end
end