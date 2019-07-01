//
//  ZSSettingViewController.swift
//  zhuishushenqi
//
//  Created by caonongyun on 2018/8/15.
//  Copyright © 2018年 QS. All rights reserved.
//

import UIKit

class ZSSettingViewController: BaseViewController {
    
    var tableView:UITableView!
    
    var viewModel:ZSSettingViewModel = ZSSettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSubviews(){
        title = "设置"
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.qs_registerCellClass(UITableViewCell.self)
        tableView.qs_registerHeaderFooterClass(ZSMyFooterView.self)
        view.addSubview(tableView)
    }
}

extension ZSSettingViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qs_dequeueReusableCell(UITableViewCell.self)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.qs_dequeueReusableHeaderFooterView(ZSMyFooterView.self)
        footer?.footerHandler = {
            self.view.showProgress()
            self.viewModel.fetchLogout(token: ZSLogin.share.token , completion: { (json) in
                self.hideProgress()
                if let ok = json?["ok"] as? Bool {
                    if ok {
                        ZSLogin.share.logout()
                        //退出登录成功,关闭菜单
                        self.navigationController?.popViewController(animated: false)
                    } else {
                        self.view.showTip(tip: "退出登录失败,请稍后再试")
                    }
                }
            })
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
