puts "🧹 Limpiando la base de datos..."
Report.destroy_all
Component.destroy_all
Computer.destroy_all
Laboratory.destroy_all
Professor.destroy_all

puts "👨‍🏫 Creando Profesores..."
professors = []
5.times do |i|
  professors << Professor.create!(
    name: "Profesor #{i+1}", 
    email: "profesor#{i+1}@unicartagena.edu.co",
    phone: "300#{rand(1000000..9999999)}",
    professor_code: "PR-#{rand(1000..9999)}",
    program: ["Ingeniería de Sistemas", "Ingeniería de Software", "Ciencias de la Computación"].sample
  )
end

puts "🏢 Creando Laboratorios..."
labs = []
3.times do |i|
  labs << Laboratory.create!(
    lab_code: "LAB-0#{i+1}",
    name: "Sala #{['Turing', 'Lovelace', 'Von Neumann'][i]}",
    capacity: [30, 40, 25].sample,
    location: "Bloque #{['A', 'B', 'C'].sample}, Piso #{rand(1..4)}"
  )
end

puts "💻 Creando Computadores y sus Componentes..."
computers = []
labs.each do |lab|
  5.times do |i|
    computer = Computer.create!(
      serial_num: "PC-#{lab.lab_code}-#{i+1}",
      status: ["Operativo", "En Mantenimiento", "Dañado"].sample,
      brand: ["Dell", "HP", "Lenovo", "Apple"].sample,
      team_num: i + 1,
      laboratory: lab
    )
    computers << computer

    Component.create!(
      name: "Teclado",
      brand: ["Logitech", "Genius", "Dell"].sample,
      serial_num: "KB-#{rand(10000..99999)}",
      status: "Operativo",
      computer: computer
    )
    Component.create!(
      name: "Mouse",
      brand: ["Logitech", "Genius", "HP"].sample,
      serial_num: "MS-#{rand(10000..99999)}",
      status: "Operativo",
      computer: computer
    )
  end
end

puts "📄 Creando Reportes..."
35.times do |i|
  Report.create!(
    report_code: "REP-#{Time.now.to_i}-#{i}",
    description: "Revisión técnica de rutina o fallo detectado en el equipo por el profesor asignado.",
    status: ["Pendiente", "En Revisión", "Resuelto"].sample,
    report_date: Time.now - rand(1..30).days,
    professor: professors.sample,
    computer: computers.sample,
    laboratory: labs.sample
  )
end

puts "✅ ¡Base de datos poblada con éxito! 🌱"
puts "📊 Resumen de tu LabManagementSystem:"
puts "- #{Professor.count} Profesores"
puts "- #{Laboratory.count} Laboratorios"
puts "- #{Computer.count} Computadores"
puts "- #{Component.count} Componentes"
puts "- #{Report.count} Reportes listos para la API"