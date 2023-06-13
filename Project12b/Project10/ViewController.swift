//
//  ViewController.swift
//  Project10
//
//  Created by BTSL.SAJID on 12/6/23.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var people: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            } catch {
                print("Faield to load data")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to deque Person Cell")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let pathURL = getDocumentsDirectory().appending(path: person.image)
        cell.imgView.image = UIImage(contentsOfFile: pathURL.path())
        
        cell.imgView.layer.borderWidth = 2
        cell.imgView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imgView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) { // not available in simulator, only on phone
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        
        dismiss(animated: true) //dismiss the image picker
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Choose", message: "rename or delete the person", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Rename Person", style: .default) { [weak self] _ in
            let renameAc = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)
            renameAc.addTextField()
            renameAc.textFields?[0].text = person.name
            renameAc.addAction(UIAlertAction(title: "Add", style: .default){ _ in
                guard let newName = renameAc.textFields?[0].text else { return }
                person.name = newName
                self?.save()
                collectionView.reloadItems(at: [indexPath])
            })
            renameAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(renameAc, animated: true)
        })
        ac.addAction(UIAlertAction(title: "Delete Person", style: .destructive) { [weak self] _ in
            self?.people.remove(at: indexPath.item)
            collectionView.reloadData()
        })
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(people) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people!")
        }
    }
}
