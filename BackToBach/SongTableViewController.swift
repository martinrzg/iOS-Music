
import UIKit

class SongTableViewController: UITableViewController {
    
    var songs = [Song]()
    var selected : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s1 = Song(title: "XO Tour Llif3", artist: "Lil Uzi")
        let s2 = Song(title: "Call me", artist: "Nav")
        let s3 = Song(title: "Rockstar", artist: "Postmalone")

        
        songs.append(s1);
        songs.append(s2);
        songs.append(s3);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as?
            SongTableViewCell else {
                fatalError("Error al cargar celda como objeto")
        }
        let song = songs[indexPath.row]
        cell.name.text = "\(song.title) -> \(song.artist)"
        cell.song = song
        cell.nav = navigationController
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ViewController
        {
            
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                
                let vc = segue.destination as? ViewController
                let song = songs[selectedRow]
                vc?.song = song
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        
    }
    
}
