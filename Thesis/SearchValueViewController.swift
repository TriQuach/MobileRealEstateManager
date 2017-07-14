//
//  SearchValueViewController.swift
//  Thesis
//
//  Created by Tri Quach on 7/7/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class SearchValueViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate {
    
    
    var value:String = "Tất cả"
    var valueIndex:Int = 0
    var idWard:Int = 999
    var mangCity:[String] = [
        "Tất cả",
        "Hồ Chí Minh"
    ]
    
    var mangDistrict:[String] = [
        "Tất cả",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "Thủ Đức",
        "Gò Vấp",
        "Bình Thạnh",
        "Tân Bình",
        "Tân Phú",
        "Phú Nhuận",
        "Bình Tân",
        "Củ Chi",
        "Hóc Môn",
        "Bình Chánh",
        "Nhà Bè",
        "Cần Giờ"
    ]
    var mangWard:[String] = []
    var mangLoai:[String] = [
        "Tất cả",
        "Căn hộ chung cư",
        "Nhà riêng",
        "Biệt thự",
        "Nhà mặt phố",
        "Đất",
        "Đất nền dự án",
        "Trang trại",
        "Khu nghỉ dưỡng",
        "Kho, xưởng"
        
    ]
    var mangDienTich:[String] = [
        "Tất cả",
        "< 30",
        "30 - 50",
        "50 - 80",
        "80 - 120",
        "120 - 200",
        "200 - 300",
        "300 - 500",
        "> 500"
    ]
    var mangGia:[String] = [
        "Tất cả",
        "< 500",
        "500 - 800",
        "800 - 1200",
        "1200 - 2000",
        "2000 - 3000",
        "3000 - 5000",
        "5000 - 7000",
        "7000 - 10000",
        "10000 - 20000",
        "> 20000"
    ]
    
    var mangSoTang:[String] = [
        "Tất cả",
        "0",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangSoPhongNgu:[String] = [
        "Tất cả",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangSoPhongTam:[String] = [
        "Tất cả",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangHuongNha:[String] = [
        "Tất cả",
        "Đông",
        "Tây",
        "Nam",
        "Bắc",
        "Đông-Bắc",
        "Tây-Bắc",
        "Tây-Nam",
        "Đông-Nam"
    ]
    var mangBanKinh:[String] = [
        "2-5km",
        "6-10km"
    ]
    
    var index:Int!
    var nameTitle:String!
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myTbv.dataSource = self
        myTbv.delegate = self
        print ("index in value:" + String(index))
        navigationController?.delegate = self
        self.title = nameTitle
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (index == 0)
        {
            return mangCity.count
        }
        else if (index == 1)
        {
            return mangDistrict.count
        }
        else if (index == 2)
        {
            return mangWard.count
        }
        else if (index == 3)
        {
            return mangLoai.count
        }
        else if (index == 4)
        {
            return mangDienTich.count
        }
        else if (index == 5)
        {
            return mangGia.count
        }
        else if (index == 6)
        {
            return mangSoTang.count
        }
        else if (index == 7)
        {
            return mangSoPhongNgu.count
        }
        else if (index == 8)
        {
            return mangSoPhongTam.count
        }
        
            return mangHuongNha.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchValueTableViewCell
        if (self.index == 0)
        {
            cell.lblValue.text = mangCity[indexPath.row]
            
        }
        else if (self.index == 1)
        {
            cell.lblValue.text = mangDistrict[indexPath.row]
        }
        else if (index == 2)
        {
            cell.lblValue.text = mangWard[indexPath.row]
        }
        else if (index == 3)
        {
            cell.lblValue.text = mangLoai[indexPath.row]
        }
        else if (index == 4)
        {
            cell.lblValue.text = mangDienTich[indexPath.row]
        }
        else if (index == 5)
        {
            cell.lblValue.text = mangGia[indexPath.row]
        }
        else if (index == 6)
        {
            cell.lblValue.text = mangSoTang[indexPath.row]
        }
        else if (index == 7)
        {
            cell.lblValue.text = mangSoPhongNgu[indexPath.row]
        }
        else if (index == 8)
        {
            cell.lblValue.text = mangSoPhongTam[indexPath.row]
        }
        else if (index == 9)
        {
            cell.lblValue.text = mangHuongNha[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (index == 0)
        {
            value = mangCity[indexPath.row]
            
            navigationController?.popViewController(animated: true)
        }
        else if (index == 1)
        {
            value = mangDistrict[indexPath.row]
            index = 1
            idWard = indexPath.row
            navigationController?.popViewController(animated: true)
        }
        else if (index == 2)
        {
            value = mangWard[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 3)
        {
            value = mangLoai[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 4)
        {
            value = mangDienTich[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 5)
        {
            value = mangGia[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 6)
        {
            value = mangSoTang[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 7)
        {
            value = mangSoPhongNgu[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 8)
        {
            value = mangSoPhongTam[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        else if (index == 9)
        {
            value = mangHuongNha[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
        valueIndex = indexPath.row
        
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? SearchNewViewController)?.mangSecondLabel[index] = value
        
        (viewController as? SearchNewViewController)?.mangIndex[index] = valueIndex
        
        if (index == 1)
        {
            (viewController as? SearchNewViewController)?.index2 = 1
            (viewController as? SearchNewViewController)?.idWard = idWard
        }
    }
    

  

}

