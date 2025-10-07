# README

## Usersテーブル

| Column | Type   | Options.   |
|--------|--------|------------|
| name   | string | null:false |
| email  | string | null:false, unique:true |
| encrypted_password | string  | null:false |
| role   | string | null:false |

### Association
has_many:students

## Studentsテーブル

| Column      | Type   | Options.   |
|-------------|--------|------------|
| stu_name    | string | null:false |
| goal_school | string | null:false |
| start_date  | date   | null:false |
| goal_date   | date   | null:false |

### Association
has_many:plans

## Plansテーブル

| Column      | Type   | Options.   |
|-------------|--------|------------|
| start_date  | date   | null:false |
| goal_date   | date   | null:false |
| student_id  | references | foreign_key:true |
| material_id | references | foreign_key:true |

### Association
belongs_to:student
belongs_to:material

## Materialsテーブル

| Column         | Type    | Options.   |
|----------------|---------|------------|
| title          | string  | null:false |
| weeks_required | integer | null:false |

### Association
has_many:plans