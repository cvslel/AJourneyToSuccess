//
//  ViewController.swift
//  AJourneyToSuccess
//
//  Created by Cenker Soyak on 6.10.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let person = ViewController.person
    var personsOfNeon = [NeonApps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
            
    }
    func createUI(){
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        view.addSubview(tableView)
        tableView.isEditing = true
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let teamName = getTeamName(section: section)
        return person.filter{
            $0.department == teamName
        }.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let teamName = getTeamName(section: indexPath.section)
        
        let team = person.filter { $0.department == teamName}
        print(team)
        let newTeam = team[indexPath.row]
        cell.textLabel?.text = newTeam.name +  " " + newTeam.surname
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        getTeamName(section: section)
    }
    func getTeamName(section : Int) -> String {
        switch section {
        case 0:
            return "iOS Team"
        case 1:
            return "Android Team"
        case 2:
            return "Design Team"
        default:
            return "D"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var movedMember = ViewController.person.remove(at: sourceIndexPath.row)
        ViewController.person.insert(movedMember, at: destinationIndexPath.row)
    }
}

extension ViewController {
    struct NeonApps {
        var name: String
        var surname: String
        var department: String
        var age: Int
        var hometown: String
        var mail: String
    }
    
    static var person : [NeonApps] = [
        NeonApps(name: "Cenker", surname: "Soyak", department: "iOS Team", age: 21, hometown: "Izmir", mail: "cenkersyk@gmail.com"),
        NeonApps(name: "Mahmut", surname: "Şenbek", department: "iOS Team", age: 25, hometown: "Tokat", mail: "mahmutsnbek@gmail.com"),
        NeonApps(name: "Ali", surname: "Aydın", department: "Design Team", age: 23, hometown: "Istanbul", mail: "ipekaydn@gmail.com"),
        NeonApps(name: "Gamze", surname: "Sarıyer", department: "Design Team", age: 26, hometown: "Aydın", mail: "gmzesariyer@gmail.com"),
        NeonApps(name: "Eren", surname: "Yılmazer", department: "Android Team", age: 24, hometown: "Izmir", mail: "erenylmazer@gmail.com"),
        NeonApps(name: "Pelin", surname: "Can", department: "Android Team", age: 22, hometown: "Istanbul", mail: "pelincn@gmail.com")
    ]
}

