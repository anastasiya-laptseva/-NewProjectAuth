//
//  TableViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let segueID = "profileVC"
    let segueStudentId = "studentProfile"
    let contentManager = JsonManager()
    
//    let genderPrototypes = [GenderPrototype(bacgkroundColor: UIColor(red: 255.0/254.0, green: 255.0/252.0, blue: 1.0, alpha: 100)), GenderPrototype(bacgkroundColor: UIColor(red: 255.0/234.0, green: 255.0/191.0, blue: 255.0/235.0, alpha: 1.0)), GenderPrototype(bacgkroundColor: UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>))]
    
    var color = UIColor(rgb: 0xFEFC9B)
    
    let genderPrototypes = [GenderPrototype(bacgkroundColor: UIColor(rgb: 0xFEFC9B)), GenderPrototype(bacgkroundColor: UIColor(rgb: 0xEABFEB)), GenderPrototype(bacgkroundColor: UIColor(rgb: 0x76D6FF))]
    
//    static var arrayStudents = [
//        Student(imageName: "BruceBenner", name: "Bruce", surname: "Benner", age: "35", info: "Вымышленный персонаж, супергерой комиксов издательства Marvel Comics. Халк был Создан Стэном Ли и Джеком Кёрби, он впервые появился в комиксе «Невероятный Халк» #1 (май 1962 года). С тех пор он стал одним из самых узнаваемых персонажей. Халк является главным героем телесериала с побочными телефильмами, где Брюса Беннера сыграл Билл Биксби, а Халка Лу Ферриньо, мультсериалов 1982, 1996 и 2013 годов и двух кинофильмов, в первом 2003 года роль Брюса Бэннера исполнил Эрик Бана, а в вышедшем в июне 2008 года перезапуске его сыграл Эдвард Нортон. С 2012 года в фильмах Кинематографической вселенной Marvel роль Халка исполняет Марк Руффало.", gender: .preferNotToSay),
//        Student(imageName: "CarolDanvers", name: "Carol", surname: "Danvers", age: "25", info: "Персонаж, супергероиня появившаяся в комиксах издательства Marvel Comics. Созданная писателем Роем Томасом и художником Джином Коланом майор Кэрол Дэнверс впервые появилась как служащая ВВС США в Super Heroes № 13 (март 1968). После слияния её человеческих генов с генами инопланетной расы Крии она получила сверхчеловеческие силы, которые были показаны в Captain Marvel № 18 (ноябрь 1969), и дебютировала как первая Мисс Марвел (англ. Ms. Marvel) в Ms. Marvel № 1 (январь 1977). В разные периоды своей истории была также известна как Двойная звезда (англ. Binary), Птица Войны (англ. Warbird) и Капитан Марвел (англ. Captain Marvel), являлась членом различных супергеройских команд, таких как Мстители, Защитники, Люди Икс, Стражи Галактики и организация Щ. И. Т. Была представлена в других лицензированных продуктах Marvel, включая мультсериалы, анимационные фильмы, телесериалы и видеоигры. В 2019 году дебютировала в кино, став главной героиней фильма «Капитан Марвел», являющегося частью кинематографической вселенной Marvel.", gender: .female),
//        Student(imageName: "DoctorStrange", name: "Doctor", surname: "Strange", age: "30", info: "Американский супергеройский фильм о персонаже Marvel Comics Докторе Стрэндже. Созданием картины занималась компания Marvel Studios, права на распространение принадлежат Walt Disney Studios Motion Pictures. Эта картина стала четырнадцатым фильмом Кинематографической вселенной MarveI, а также вторым фильмом третьей фазы. Скотт Дерриксон выступил в качестве режиссёра[1], а Джон Спэйтс написал сценарий. Главную роль исполнил британский актёр Бенедикт Камбербэтч[6]. Также в картине сыграли Мадс Миккельсен, Чиветел Эджиофор, Рэйчел Макадамс, Бенедикт Вонг и Тильда Суинтон. Задумка перенести Доктора Стрэнджа со страниц комиксов на большой экран появилась ещё в 1980-х годах, однако проект неоднократно откладывался, вплоть до того момента, пока Paramount Pictures не приобрела права на персонажа от имени Marvel Studios. В начале 2010 года Томас Дин Доннелли и Джошуа Оппенхаймер (англ.)русск. занялись сценарием к фильму. В июне 2014 года Скотт Дерриксон занял место режиссёра фильма. Кастинг начался в декабре 2014 года. В то же время Камбербэтч получил главную роль. Спэйтс был нанят, чтобы переписать сценарий к фильму, в то время как Каргилл также присоединился к «Доктору Стрэнджу» для работы над сценарием вместе с Дерриксоном. Основные съёмки начались в ноябре 2015 года в Непале, а затем продолжились в Великобритании и завершились в апреле 2016 года в Нью-Йорке.", gender: .male),
//        Student(imageName: "NatashaRomanoff", name: "Natasha", surname: "Romanoff", age: "27", info: "Название нескольких персонажей вселенной Marvel Comics. Самый первый и популярный носивший это прозвище персонаж — Наталья (Наташа) Альяновна Романова[6]. Была создана редактором Стэном Ли, писателем Доном Рико и художником Доном Хеком и дебютировала в Tales of Suspense # 52 в апреле 1964 года.", gender: .female),
//        Student(imageName: "PeterParker", name: "Peter", surname: "Parker", age: "18", info: "Персонаж, супергерой, появляющийся в комиксах издательства Marvel Comics, созданный Стэном Ли и Стивом Дитко. С момента своего первого появления на страницах комикса Amazing Fantasy №15 (рус. Удивительная фантазия, август 1962) он стал одним из самых популярных супергероев. Ли и Дитко задумывали персонажа как подростка-сироту, воспитанного дядей и тётей, совмещающего жизнь обычного студента и борца с преступностью. Человек-паук получил суперсилу, увеличенную ловкость, «паучье чутьё», а также способность держаться на отвесных поверхностях и выпускать паутину из рук с использованием прибора собственного изобретения.", gender: .preferNotToSay),
//        Student(imageName: "StevenRogers", name: "Steven", surname: "Rogers", age: "80", info: "Вымышленный персонаж, супергерой комиксов издательства Marvel Comics. Один из самых известных персонажей в мире комиксов. Он был создан писателем Джо Саймоном и художником Джеком Кирби и впервые появился в комиксах 1940-х «Timely Comics»[3]. За годы в общей сложности в 75 странах было продано около 210 миллионов копий комиксов «Captain America» (оценки разнятся, в некоторых источниках эта цифра немного больше или меньше)[4]. Капитан Америка одет в костюм, раскрашенный на мотив американского флага, и вооружён неразрушимым щитом, который часто используется в качестве оружия. В комиксах обращение «Капитан Америка» применяется к любому, кто выбран правительством США (которое рассматривает себя «владеющим» персоной) носить костюм и щит. Почти всю историю публикаций персонажа Капитан Америка был альтер эго Стива Роджерса (англ. Steve Rogers), болезненного юноши, организм которого был усилен экспериментальной сывороткой до максимума физической формы, доступной человеку, чтобы помочь военным силам США в проведении военных операций. Роджерс всегда был приверженцем Справедливости, ради которой шёл на многие жертвы; несмотря ни на что, всегда приходил на помощь своим союзникам. Капитан Америка — целенаправленно созданный патриотический персонаж; он был самым популярным персонажем в период Второй мировой войны, его часто изображали сражающиеся с гитлеровской коалицией государства. После окончания войны популярность персонажа уменьшилась, и к 50-м годам его перестали использовать, за исключением неудачной попытки возрождения в 1953 году. Персонаж стал вновь использоваться в комиксах лишь в период, известный как Серебряный век комиксов, когда стал членом команды супергероев Мстителей в выпускеThe Avengers #4 (март 1964). Также активно участвовал в арке комиксов «Алтимейт». Капитан Америка выдерживал удар Часового.", gender: .male),
//        Student(imageName: "ThorOdson", name: "Thor", surname: "Odson", age: "1000", info: "Супергерой комиксов издательства Marvel Comics. Персонаж основан на образе одноимённого бога из германо-скандинавской мифологии. Его авторы в Marvel — редактор Стэн Ли, сценарист Ларри Либер и художник Джек Кёрби, а первое появление приходится на комикс Journey into Mystery #83 (1962), который позже сменил название на «The Mighty Thor».", gender: .preferNotToSay),
//        Student(imageName: "TonyStark", name: "Tony", surname: "Stark", age: "40", info: "Персонаж, изданий Marvel Comics и их адаптаций, созданный писателем Стэном Ли, сценаристом Ларри Либером и художниками Доном Хэком[en] и Джеком Кёрби; первое появление Железного Человека состоялось в комиксе Tales of Suspense #39 в марте 1963 года. В первоначальном варианте своей биографии Тони Старк, гениальный изобретатель и богатейший промышленник с репутацией плейбоя, страдает от ранения, полученного им в плену, где его вынудили разработать для террористов оружие массового поражения. Вместо этого он создаёт высокотехнологичный костюм-броню, с помощью которого сбегает из плена. Позднее Старк улучшает свою броню вооружением и устройствами, созданными на базе ресурсов его компании, и использует доспех, чтобы защищать мир в облике Железного человека, первое время скрывая свою личность.Перейти к разделу «#Биография» Первоначально Железный человек, будучи порождением Холодной войны и Вьетнамской войны, в частности, был для Стэна Ли средством раскрытия их соответствующих тем и роли американской экономики в борьбе с коммунизмом; со временем в последующих переосмыслениях образа упор стал делаться на проблемы корпоративного криминала и терроризма.Перейти к разделу «#История публикаций» На протяжении времени публикаций Железный человек связан в первую очередь с командой Мстителей, будучи одним из её сооснователей, и нескольких побочных от неё команд супергероев; его сольная серия, запущенная в мае 1968 года, пережила 5 томов, издаваясь с перерывом в 2008—2012 годах, когда её сменила серия The Invincible Iron Man, вплоть до 2014 года. Впоследствии, с ростом популярности, Железный человек стал персонажем нескольких мультсериалов и мультфильмов, причём как сольных, так и в составе Мстителей. В фильмах, относящихся к кинематографической вселенной Marvel, его роль играет актёр Роберт Дауни-младший.", gender: .male)
//    ]
    
    static var arrayStudents: [Student]? = nil
    
    var selectedStudent: Student?
    var selectedColor: UIColor?
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
//       students = prepareArray()
//        self.tableView.register(CodeTableViewCell.self, forCellReuseIdentifier: CodeTableViewCell.id)
//       tableView.register(UINib(nibName: "XIB", bundle: nil), forCellReuseIdentifier: XIB.id)
        
            
        let dataJson = self.contentManager.LoadFileAsString(name: "Student", type: "json")
            
        let json = try? JSONSerialization.jsonObject(with: dataJson, options: [])
        if let recipe = json as? [String: Any] {
            if let array = recipe["students"] as? Array<[String:String]>{
                TableViewController.arrayStudents = []
                for element in array {
                    let student = Student(object: element)
                    TableViewController.arrayStudents?.append(student)
                }
            }
        }
        
        tableView.reloadData()
   }
    
//    func prepareArray() -> [Student] {
//        var array: [Student] = []
//        guard let path = Bundle.main.path(forResource: "Names", ofType: "txt") else { return array }
//
//        var allStudentString: String = " "
//
//        do {
//            var allStudentString = try String(contentsOfFile: path)
//        } catch { }
//
//        var splittedNames = allStudentString.split(separator: " ")
//
//        splittedNames.forEach { name in
//            array.append(Student(name: String(name)))
//
//        }
//
//        return array
//    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewController.arrayStudents?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let student = TableViewController.arrayStudents?[indexPath.row] else {
            return cell
        }

        switch student.getGender() {
            case .male:
                cell.backgroundColor = genderPrototypes[2].bacgkroundColor
                break
            case .female:
                cell.backgroundColor = genderPrototypes[1].bacgkroundColor
                break
            case .preferNotToSay:
                cell.backgroundColor = genderPrototypes[0].bacgkroundColor
                break
        }


        cell.textLabel?.text =  "\(student.name) \(student.surname)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudent = TableViewController.arrayStudents?[indexPath.row]
        selectedColor = tableView.cellForRow(at: indexPath)?.backgroundColor ?? .white
        self.performSegue(withIdentifier: segueStudentId, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TableViewController.arrayStudents?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateData()
        }
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueStudentId{
            let studentProfile = segue.destination as! ProfifeInfoController
            studentProfile.student = selectedStudent
            studentProfile.isEditProfile = false
            studentProfile.color = selectedColor
        }
    }
    
    
}
