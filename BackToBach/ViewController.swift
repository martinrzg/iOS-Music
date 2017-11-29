
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player : AVAudioPlayer = AVAudioPlayer()
    var song : Song?
    
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var sliderScrub: UISlider!
    @IBOutlet weak var songTitle: UINavigationItem!
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event!.subtype == UIEventSubtype.motionShake {
            player.play()
        }
    }
    
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func stop(_ sender: Any) {
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: song?.title, ofType: "mp3")!))
        }
        catch {
            
        }
    }
    
    
    @IBAction func scrub(_ sender: Any) {
        player.currentTime = TimeInterval(sliderScrub.value)
    }
    
    @IBAction func adjustVolume(_ sender: Any) {
        player.volume = sliderVolume.value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SongTableViewController {
            player.pause()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTitle.title = song?.title
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: song?.title, ofType: "mp3")!))
            
            sliderScrub.maximumValue = Float(player.duration)
        }
        catch {
            
        }
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubSlider), userInfo: nil, repeats: true)
    }
    
    func updateScrubSlider(){
        sliderScrub.value = Float(player.currentTime)
        print(Float(player.currentTime))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

