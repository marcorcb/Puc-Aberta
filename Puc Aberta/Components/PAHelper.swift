//
//  PAHelper.swift
//  Puc Aberta
//
//  Created by Marco Braga on 01/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

extension String {
    func isValidCpf() -> Bool {
        let numbers = self.flatMap({Int(String($0))})
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
}

extension UISegmentedControl {
    func replaceSegments(segments: [String]) {
        self.removeAllSegments()
        for segment in segments {
            self.insertSegment(withTitle: segment, at: self.numberOfSegments, animated: false)
        }
    }
}
/*
{
    "units": [
    {
    "name": "Barreiro",
    "schedule": [
    {
    "dates": [
    "12/09/2018", "13/09/2018"
    ],
    "type": "Oficina",
    "events": [
    {
    "location": "Auditório do Prédio 5",
    "time_period": [
    {
    "start_time": "07:30",
    "end_time": "11:00",
    "schedule_description": [
    {
    "time": "07:30",
    "description": "Credenciamento e escolha das oficinas"
    },
    {
    "time": "08:00",
    "description": "Acolhida Institucional"
    },
    {
    "time": "08:40",
    "description": "Inicio das oficinas e Feira de Cursos"
    },
    {
    "time": "11:00",
    "description": "Encerramento"
    }
    ]
    },
    {
    "start_time": "18:45",
    "end_time": "21:50",
    "schedule_description": [
    {
    "time": "18:45",
    "description": "Credenciamento e escolha das oficinas"
    },
    {
    "time": "19:00",
    "description": "Acolhida Institucional"
    },
    {
    "time": "19:30",
    "description": "Inicio das oficinas e Feira de Cursos"
    },
    {
    "time": "21:50",
    "description": "Encerramento"
    }
    ]
    }
    ],
    "activities": [
    {
    "course": "Administração",
    "activity": "Jogos Empresariais: o jogo da ponte"
    },
    {
    "course": "Ciências Contábeis",
    "activity": "Contabilize as jogadas do seu dia a dia por meio do Banco Imobiliário"
    },
    {
    "course": "Direito",
    "activity": "Júri Simulado"
    },
    {
    "course": "Enfermagem",
    "activity": "Suporte Básico de vida e uso do Desfibrilador Externo Automático (DEA)"
    },
    {
    "course": "Engenharia Civil",
    "activity": "Jogada de Engenheiro"
    },
    {
    "course": "Engenharia de Controle e Automação*",
    "activity": "Introdução aos sistemas de automação"
    },
    {
    "course": "Engenharia de Produção e Tec. em Logística",
    "activity": "Varejão das Balas"
    },
    {
    "course": "Engenharia Elétrica*",
    "activity": "Sistemas Elétricos"
    },
    {
    "course": "Engenharia Mecânica*",
    "activity": "Por dentro da Engenharia Mecânica"
    },
    {
    "course": "Nutrição",
    "activity": "Os dez passos para uma alimentação saudável"
    },
    {
    "course": "Sistemas de Informação",
    "activity": "Crie e publique seu aplicativo em 20 minutos"
    },
    {
    "course": "Tec. em Gestão Financeira",
    "activity": "Jogo de investimento"
    }
    ],
    "extra_information": "* cursos ofertados na PUC Minas Contagem"
    }
    ]
    }
    ]
    },
    {
    "name": "Betim",
    "schedule": [
    {
    "dates":
    [
    "21/09/2018"
    ],
    "type": "Palestra",
    "events": [
    {
    "group": "A",
    "description": "",
    "location": "Espaço de palestra",
    "start_times": [
    "08:30", "19:00"
    ],
    "courses": [
    "Administração", "Direito", "Engenharia de Produção", "Sistemas de Informação"
    ]
    },
    {
    "group": "B",
    "description": "",
    "location": "Espaço de palestra",
    "start_times": [
    "08:30", "19:00"
    ],
    "courses": [
    "Biomedicina", "Medicina Veterinária"
    ]
    },
    {
    "group": "C",
    "description": "",
    "location": "Espaço de palestra",
    "start_times": [
    "08:30", "19:00"
    ],
    "courses": [
    "Enfermagem", "Fisioterapia", "Medicina", "Psicologia"
    ]
    }
    ]
    },
    {
    "dates":
    [
    "22/09/2018"
    ],
    "type": "Palestra",
    "events": [
    {
    "group": "A",
    "description": "",
    "location": "Espaço de palestra",
    "start_times": [
    "08:30"
    ],
    "courses": [
    "Administração", "Direito", "Engenharia de Produção", "Sistemas de Informação"
    ]
    },
    {
    "group": "B",
    "description": "",
    "location": "Espaço de palestra",
    "start_times": [
    "08:30"
    ],
    "courses": [
    "Biomedicina", "Medicina Veterinária"
    ]
    },
    {
    "group": "C",
    "description": "",
    "location": "Espaço de palestra",
    "start_times": [
    "08:30"
    ],
    "courses": [
    "Enfermagem", "Fisioterapia", "Medicina", "Psicologia"
    ]
    }
    ]
    }
    ]
    },
    {
    "name": "Contagem",
    "schedule": [
    {
    "dates": [
    "24/05/2018"
    ],
    "type": "Misto",
    "events": [
    {
    "time_period": [
    {
    "start_time": "07:30",
    "end_time": "11:00"
    },
    {
    "start_time": "18:30",
    "end_time": "22:00"
    }
    ],
    "activities": [
    {
    "type": "Abertura",
    "activity": "Acolhida institucional PUC Contagem e apresentação dos cursos por área",
    "location": "Teatro Padre de Man - Entrada acesso 7"
    },
    {
    "type": "Oficina",
    "activity": "Oficinas (atividades práticas) dos cursos da PUC Minas Contagem",
    "location": "Diversos",
    "courses": [
    "Administração", "Ciências Contábeis", "Direito", "Engenharia Mecânica", "Engenharia Elétrica", "Sistemas de Informação"
    ]
    },
    {
    "type": "Feira",
    "activity": "Visita à feira de cursos ofertados na PUC Minas Barreiro e Betim",
    "location": "Quadra poliesportiva",
    "courses": [
    "Biomedicina", "Enfermagem", "Engenharia Civil", "Engenharia de Produção", "Fisioterapia", "Medicina", "Medicina Veterinária", "Psicologia", "Gestão Financeira", "Logística"
    ]
    }
    ]
    }
    ]
    },
    {
    "dates": [
    "25/05/2018"
    ],
    "type": "Misto",
    "events": [
    {
    "time_period": [
    {
    "start_time": "07:30",
    "end_time": "11:00"
    }
    ],
    "activities": [
    {
    "type": "Abertura",
    "activity": "Acolhida institucional PUC Contagem e apresentação dos cursos por área",
    "location": "Teatro Padre de Man - Entrada acesso 7"
    },
    {
    "type": "Oficina",
    "activity": "Oficinas (atividades práticas) dos cursos da PUC Minas Contagem",
    "location": "Diversos",
    "courses": [
    "Administração", "Ciências Contábeis", "Direito", "Engenharia Mecânica", "Engenharia Elétrica", "Sistemas de Informação"
    ]
    },
    {
    "type": "Feira",
    "activity": "Visita à feira de cursos ofertados na PUC Minas Barreiro e Betim",
    "location": "Quadra poliesportiva",
    "courses": [
    "Biomedicina", "Enfermagem", "Engenharia Civil", "Engenharia de Produção", "Fisioterapia", "Medicina", "Medicina Veterinária", "Psicologia", "Gestão Financeira", "Logística"
    ]
    }
    ]
    }
    ]
    }
    ]
    },
    {
    "name": "Coração Eucarístico",
    "schedule": [
    {
    "dates":
    [
    "08/05/2018", "09/05/2018", "10/05/2018", "11/05/2018"
    ],
    "type": "Palesta",
    "description": "13h - Receptivo / Credenciamento / Abertura da Feira \n 13h30- Palestras do 1° grupo/Visitação à Feira de Cursos \n 16h – Palestras do 2° grupo/Visitação à Feira de Cursos \n 18h – Encerramento das atividades",
    "events": [
    {
    "group": "A",
    "description": "Engenharias",
    "location": "Teatro",
    "start_times": [
    "13:30"
    ],
    "courses": [
    "Engenharia Aeronáutica", "Engenharia Civil", "Engenharia de Controle e Automação", "Engenharia de Energia", "Engenharia de Produção", "Engenharia Elétrica", "Engenharia Eletrônica e de Telecomunicação", "Engenharia Mecânica", "Engenharia Mecânica Ênfase Mecatrônica", "Engenharia Metalúrgica e Engenharia Química"
    ]
    },
    {
    "group": "B",
    "description": "Direito",
    "location": "Auditório 1 - Prédio 4",
    "start_times": [
    "13:30"
    ],
    "courses": [
    "Direito"
    ]
    },
    {
    "group": "C",
    "description": "Palestra da Área Gerencial",
    "location": "Auditório 2 - Prédio 5",
    "start_times": [
    "13:30"
    ],
    "courses": [
    "Administração (presencial e a distância)", "Ciências Contábeis (presencial e a distância)", "Ciências Econômicas", "Gestão Financeira (graduação tecnológica)",
    "Logística (graduação tecnológica)"
    ]
    },
    {
    "group": "D",
    "description": "Palestra Saúde",
    "location": "Auditório 3 - Prédio 43",
    "start_times": [
    "13:30"
    ],
    "courses": [
    "Biomedicina", "Ciências Biológicas (bacharelado/licenciatura)", "Educação Física (bacharelado/licenciatura)", "Fonoaudiologia", "Medicina Veterinária", "Nutrição", "Odontologia"
    ]
    },
    {
    "group": "E",
    "description": "Palestra Ciências Humanas",
    "location": "Auditório Multiuso - Prédio 43",
    "start_times": [
    "13:30"
    ],
    "courses": [
    "Geografia (bacharelado/licenciatura)", "História (bacharelado/licenciatura)", "Letras (bacharelado/licenciatura em Português /Português-Inglês)", "Pedagogia (licenciatura)"
    ]
    },
    {
    "group": "F",
    "description": "Enfermagem, Fisioterapia e Medicina",
    "location": "Teatro",
    "start_times": [
    "16:00"
    ],
    "courses": [
    "Enfermagem", "Fisioterapia", "Medicina"
    ]
    },
    {
    "group": "G",
    "description": "Palestra Psicologia",
    "location": "Auditório 1 - Prédio 4",
    "start_times": [
    "16:00"
    ],
    "courses": [
    "Psicologia"
    ]
    },
    {
    "group": "H",
    "description": "Palestra Comunicação",
    "location": "Auditório 2 - Prédio 5",
    "start_times": [
    "16:00"
    ],
    "courses": [
    "Cinema e Audiovisual", "Jornalismo", "Publicidade e Propaganda", "Relações Públicas"
    ]
    },
    {
    "group": "I",
    "description": "Palestra Área Social",
    "location": "Auditório 3 - Prédio 43",
    "start_times": [
    "16:00"
    ],
    "courses": [
    "Arquitetura e Urbanismo", "Ciências Sociais (bacharelado/licenciatura)", "Relações Internacionais", "Serviço Social"
    ]
    },
    {
    "group": "J",
    "description": "Palestra Exatas e Informática",
    "location": "Auditório Multiuso - Prédio 43",
    "start_times": [
    "16:00"
    ],
    "courses": [
    "Ciência da Computação", "Engenharia de Computação", "Engenharia de Software", "Física (licenciatura)", "Jogos Digitais (graduação tecnológica)", "Matemática (licenciatura)", "Sistemas de Informação"
    ]
    }
    ]
    }
    ]
    },
    {
    "name": "São Gabriel",
    "schedule": [
    {
    "dates": [
    "23/05/2018", "24/05/2018", "25/05/2018"
    ],
    "type": "Oficina"
    },
    {
    "dates": [
    "23/05/2018", "24/05/2018", "25/05/2018"
    ]
    }
    ]
    }
    ]
}
*/
