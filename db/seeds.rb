departments = [
  { name: "Human Resources", code: "HR" },
  { name: "Engineering", code: "ENG" },
  { name: "Quality Assurance", code: "QA" },
  { name: "UI/UX Design", code: "UX" },
  { name: "DevOps", code: "DEVOPS" },
  { name: "Finance", code: "FIN" },
  { name: "Sales", code: "SLS" },
  { name: "Marketing", code: "MKT" },
  { name: "Product Management", code: "PM" },
  { name: "Business Analysis", code: "BA" },
  { name: "Technical Support", code: "SUP" },
  { name: "Legal", code: "LEG" },
  { name: "Administration", code: "ADM" },
  { name: "Security & Compliance", code: "SEC" },
  { name: "Data Science & Analytics", code: "DS" },
  { name: "Research & Development", code: "RND" },
  { name: "Training & Development", code: "TND" }
]

departments.each do |dept|
  Department.find_or_create_by!(code: dept[:code]) do |d|
    d.name = dept[:name]
  end
end
