namespace :bootstrap do
    desc "Add a single admin to the site"
    task :admin => :environment do
        Member.create(
            first_name: '',
            last_name: '',
            case_id: '',
            email: 'running@src.edu',
            password: 'password',
            year: '',
            competitive: false,
            officer: true)
    end
end