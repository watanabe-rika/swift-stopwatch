//
//  ViewController.swift
//  jakowatch
//
//  Created by 勝村里佳 on 2018/04/25.
//  Copyright © 2018年 jako. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*
     * ボタン群
     * startButton: スタート
     * stopButton:  ストップ
     * resetButton: リセット
     */
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // タイマー表示
    @IBOutlet weak var timerLabel: UILabel!

    // タイマー用変数
    var startTime: TimeInterval? = nil

    // タイマーオブジェクト
    var timer = Timer()

    // タイマー経過時間
    var elapsedTime: Double = 0.0

    // ボタンの有効状態を管理
    func setButtonEnabled(start: Bool, stop: Bool, reset: Bool) {
        // スタートボタン
        self.startButton.isEnabled = start
        // ストップボタン
        self.stopButton.isEnabled  = stop
        // リセットボタン
        self.resetButton.isEnabled = reset
    }

    // 時刻カウントアップ
    @objc func update() {
        // 経過秒数を取得
        if self.startTime != nil {
            let t: Double = Date.timeIntervalSinceReferenceDate - self.startTime! + self.elapsedTime

            // 分
            let min  = Int(t / 60)
            // 秒
            let sec  = Int(t) % 60
            // ミリ秒
            let msec = Int((t - Double(min * 60) - Double(sec)) * 100.0)

            self.timerLabel.text = String(format: "%02d:%02d:%02d", min, sec, msec)
        }
    }

    // スタート処理
    @IBAction func startAction(_ sender: Any) {
        // ストップボタンのみ押下できる
        // start: false, stop: true, reset: false
        self.setButtonEnabled(start: false, stop: true, reset: false)

        // スタートボタン押下時
        self.startTime = Date.timeIntervalSinceReferenceDate

        // タイマーオブジェクトにセット
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.update),
            userInfo: nil,
            repeats: true
        )
    }

    // ストップ処理
    @IBAction func stopAction(_ sender: Any) {
        // スタート、リセットを押下できる
        // start: true, stop: false, reset: true
        self.setButtonEnabled(start: true, stop: false, reset: true)

        // タイマーが動いていた時間をセット
        self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime!

        // タイマーを停止
        self.timer.invalidate()
    }

    // リセット処理
    @IBAction func resetAction(_ sender: Any) {
        // スタートのみ押下できる
        // start: true, stop: false, reset: false
        self.setButtonEnabled(start: true, stop: false, reset: false)

        // タイマーをリセット
        self.startTime = nil

        // タイマー経過時間をリセット
        self.elapsedTime = 0.0

        // 表示を初期化
        self.timerLabel.text = "00:00:00"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 起動直後はスタートボタンのみ有効
        // start: true, stop: false, reset: false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

