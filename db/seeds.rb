### Delete existing dataset ###
Response.all.map { |r| r.destroy }
Survey.all.map { |s| s.destroy }
Outcome.all.map { |o| o.destroy }
Career.all.map { |c| c.destroy }
Choice.all.map { |c| c.destroy }
Question.all.map { |q| q.destroy }


### Create new dataset ###

#Creating Questions
questionsDescList = [
    'Me trasladaría a una zona agrícola - ganadera para ejercer mi profesión.', 
    'Tengo buena memoria y no me cuesta estudiar y retener fórmulas y palabras técnicas.',
    'Me gusta escribir. En general mis trabajos son largos y están bien organizados.',
    'Sé quien es Steven Hawking: Conozco y me atraen sus descubrimientos.',
    'Me actualizo respecto de los avances tecnológicos y me intereso por investigar y conocer',
    'Sé quien es Andy Warhol y a qué movimiento artístico pertenece. Me apasiona conocer acerca del arte y sus exponentes.',
    'En general me intereso por las dificultades que ha tenido que atravesar la humanidad y cómo lo ha superado.',
    'Me apasiona leer y no me importa si el libro que elijo tiene muchas páginas, para mí es un gran entretenimiento.',
    'Me atrae conocer los procesos y las áreas que hacen funcionar a las empresas.',
    'Me siento identificado con el pensamiento de algunos filósofos y escritores.',
    'Me encanta estudiar el cuerpo humano y conocer cómo funciona. Además, no me impresiona la sangre.',
    'Si pudiera elegir, pasaría mucho tiempo diseñando novedosos objetos o edificios en mi computadora.',
    'Si mi blog fuera temático, trataría acerca de: ',
    'Integraría un equipo de trabajo encargado de producir un audiovisual sobre: ',
    'Sería importante destacarme como: ',
    ]

for i in 1..questionsDescList.length() do
    Question.create(number: i, description: questionsDescList[i-1], name: "Pregunta #{i.to_s}")
end


#Creating Choices
for i in 1..12 do
    Choice.create(text: 'Si', question_id: Question.find(:number => i).id)
    Choice.create(text: 'No', question_id: Question.find(:number => i).id)
end

Choice.create(text: 'La importancia de la expresión artística en el desarrollo de la identidad de los pueblos.', question_id: Question.find(:number => 13).id)
Choice.create(text: 'La arqueología urbana como forma de aprender acerca de la historia cultural de una ciudad.', question_id: Question.find(:number => 13).id)
Choice.create(text: 'La tecnología satelital en un proyecto para descubrir actividad volcánica para prevenir catástrofes climáticas.', question_id: Question.find(:number => 13).id)
Choice.create(text: 'Ninguna de las opciones.', question_id: Question.find(:number => 13).id)
Choice.create(text: 'La práctica de deportes y su influencia positiva en el estado de ánimo de las personas.', question_id: Question.find(:number => 14).id)
Choice.create(text: 'Los pensadores del siglo XX y su aporte a la gestión de las organizaciones.', question_id: Question.find(:number => 14).id)
Choice.create(text: 'Las mascotas y su incidencia en la calidad de vida de las personas no videntes.', question_id: Question.find(:number => 14).id)
Choice.create(text: 'El uso de la PC como herramienta para el control de los procesos industriales.', question_id: Question.find(:number => 14).id)
Choice.create(text: 'Procesos productivos de una empresa.', question_id: Question.find(:number => 14).id)
Choice.create(text: 'Ninguna de las opciones.', question_id: Question.find(:number => 14).id)
Choice.create(text: 'Director de una investigación técnico científica.', question_id: Question.find(:number => 15).id)
Choice.create(text: 'Gerente general de una empresa reconocida por su responsabilidad social.', question_id: Question.find(:number => 15).id)
Choice.create(text: 'Un deportista famoso por su destreza física y su ética profesional.', question_id: Question.find(:number => 15).id)
Choice.create(text: 'Experto en la detección precoz de enfermedades neurológicas en niños.', question_id: Question.find(:number => 15).id)
Choice.create(text: 'Un agente de prensa audaz, número uno en el ranking de notas a celebridades.', question_id: Question.find(:number => 15).id)
Choice.create(text: 'Ninguna de las opciones.', question_id: Question.find(:number => 15).id)


#Create Careers
careersList = [ 
                ['Agronomia', 'https://www.unrc.edu.ar/unrc/carreras/ayv_ingenieria_agronomica.htm'],
                ['Arquitectura', 'https://um.edu.ar/carreras/arquitectura-y-urbanismo/#'],
                ['Arte', 'https://isbapierini-cba.infd.edu.ar/sitio/plan-de-estudios/'],
                ['Computación', 'https://www.unrc.edu.ar/unrc/carreras/exa_lic_ciencias_computacion.php'],
                ['Economía', 'https://www.unrc.edu.ar/unrc/carreras/eco_lic_economia.htm'], 
                ['Educación física', 'https://www.unrc.edu.ar/unrc/carreras/hum_prof_educacion_fisica.php'],
                ['Filosofía', 'https://www.unrc.edu.ar/unrc/carreras/hum_lic_en_filosofia.php'],
                ['Física', 'https://www.unrc.edu.ar/unrc/carreras/exa_prof_fisica.php'],
                ['Geología', 'https://www.unrc.edu.ar/unrc/carreras/exa_lic_geologia.php'],
                ['Historia', 'https://www.unrc.edu.ar/unrc/carreras/hum_lic_historia.php'],
                ['Literaruta', 'https://www.unrc.edu.ar/unrc/carreras/hum_prof_lengua_y_literatura.php'],
                ['Matemáticas', 'https://www.unrc.edu.ar/unrc/carreras/exa_lic_matematica.php'],
                ['Medicina', 'https://fcm.unc.edu.ar/carrera-de-medicina/'],
                ['Periodismo', 'https://fcc.unc.edu.ar/fcc-carreras/licenciatura'],
                ['Química', 'https://www.unrc.edu.ar/unrc/carreras/exa_lic_quimica.php'],
                ['Sociología', 'https://sociales.unc.edu.ar/licenciaturasociologia'],
                ['Veterinaria', 'https://www.unrc.edu.ar/unrc/carreras/ayv_medicina_veterinaria.htm']
            ]
careersList.map { |c| Career.create(name: c[0], ref: c[1])}







#Create Outcomes
Outcome.create(choice_id: (Question.find(:number => 1).choices[0]).id, career_id: Career.find(:name => 'Veterinaria').id)
Outcome.create(choice_id: (Question.find(:number => 1).choices[0]).id, career_id: Career.find(:name => 'Agronomia').id)
Outcome.create(choice_id: (Question.find(:number => 2).choices[0]).id, career_id: Career.find(:name => 'Física').id)
Outcome.create(choice_id: (Question.find(:number => 2).choices[0]).id, career_id: Career.find(:name => 'Matemáticas').id)
Outcome.create(choice_id: (Question.find(:number => 2).choices[0]).id, career_id: Career.find(:name => 'Química').id)
Outcome.create(choice_id: (Question.find(:number => 2).choices[0]).id, career_id: Career.find(:name => 'Computación').id)
Outcome.create(choice_id: (Question.find(:number => 3).choices[0]).id, career_id: Career.find(:name => 'Literaruta').id)
Outcome.create(choice_id: (Question.find(:number => 3).choices[0]).id, career_id: Career.find(:name => 'Historia').id)
Outcome.create(choice_id: (Question.find(:number => 4).choices[0]).id, career_id: Career.find(:name => 'Física').id)
Outcome.create(choice_id: (Question.find(:number => 5).choices[0]).id, career_id: Career.find(:name => 'Computación').id)
Outcome.create(choice_id: (Question.find(:number => 6).choices[0]).id, career_id: Career.find(:name => 'Arte').id)
Outcome.create(choice_id: (Question.find(:number => 7).choices[0]).id, career_id: Career.find(:name => 'Historia').id)
Outcome.create(choice_id: (Question.find(:number => 8).choices[0]).id, career_id: Career.find(:name => 'Literaruta').id)
Outcome.create(choice_id: (Question.find(:number => 8).choices[0]).id, career_id: Career.find(:name => 'Historia').id)
Outcome.create(choice_id: (Question.find(:number => 9).choices[0]).id, career_id: Career.find(:name => 'Economía').id)
Outcome.create(choice_id: (Question.find(:number => 10).choices[0]).id, career_id: Career.find(:name => 'Filosofía').id)
Outcome.create(choice_id: (Question.find(:number => 10).choices[0]).id, career_id: Career.find(:name => 'Historia').id)
Outcome.create(choice_id: (Question.find(:number => 11).choices[0]).id, career_id: Career.find(:name => 'Medicina').id)
Outcome.create(choice_id: (Question.find(:number => 12).choices[0]).id, career_id: Career.find(:name => 'Computación').id)
Outcome.create(choice_id: (Question.find(:number => 12).choices[0]).id, career_id: Career.find(:name => 'Arquitectura').id)

Outcome.create(choice_id: (Question.find(:number => 13).choices[0]).id, career_id: Career.find(:name => 'Sociología').id)
Outcome.create(choice_id: (Question.find(:number => 13).choices[1]).id, career_id: Career.find(:name => 'Historia').id)
Outcome.create(choice_id: (Question.find(:number => 13).choices[2]).id, career_id: Career.find(:name => 'Computación').id)
Outcome.create(choice_id: (Question.find(:number => 13).choices[2]).id, career_id: Career.find(:name => 'Geología').id)
Outcome.create(choice_id: (Question.find(:number => 14).choices[0]).id, career_id: Career.find(:name => 'Educación física').id)
Outcome.create(choice_id: (Question.find(:number => 14).choices[1]).id, career_id: Career.find(:name => 'Filosofía').id)
Outcome.create(choice_id: (Question.find(:number => 14).choices[1]).id, career_id: Career.find(:name => 'Historia').id)
Outcome.create(choice_id: (Question.find(:number => 14).choices[2]).id, career_id: Career.find(:name => 'Veterinaria').id)
Outcome.create(choice_id: (Question.find(:number => 14).choices[3]).id, career_id: Career.find(:name => 'Computación').id)
Outcome.create(choice_id: (Question.find(:number => 14).choices[4]).id, career_id: Career.find(:name => 'Economía').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[0]).id, career_id: Career.find(:name => 'Física').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[0]).id, career_id: Career.find(:name => 'Química').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[0]).id, career_id: Career.find(:name => 'Computación').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[1]).id, career_id: Career.find(:name => 'Economía').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[2]).id, career_id: Career.find(:name => 'Educación física').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[3]).id, career_id: Career.find(:name => 'Medicina').id)
Outcome.create(choice_id: (Question.find(:number => 15).choices[4]).id, career_id: Career.find(:name => 'Periodismo').id)