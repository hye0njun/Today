//
//  ReminderListViewController.swift
//  Today
//
//  Created by 황현준 on 2024/01/24.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    //Add a type alias for the diffable data source.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

    
    var dataSource: DataSource!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //새로운 레이아웃 생성
        let listLayout = listLayout()
        //collectionViewLayout에 listLayout을 할당
        collectionView.collectionViewLayout = listLayout
        
        //새로운 셀 등록(셀의 내용과 모양 구성 방법 지시)
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            //항목에 해당하는 알림을 검색
            let reminder = Reminder.sampleData[indexPath.item]
            //셀의 기본 컨텐츠 구성 검색, defaultContentConfiguration()는 사전 정의된 시스템 스타일로 콘텐츠 구성을 생성합니다.
            var contentConfiguration = cell.defaultContentConfiguration()
            //Assign reminder.title to the content configuration text.
            contentConfiguration.text = reminder.title
            //셀에 컨텐츠 구성 할당
            cell.contentConfiguration = contentConfiguration
        }
        
        //새로운 데이터소스 등록
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            //셀 등록을 사용하여 셀을 대기열에서 빼고 반환합니다.
            return collectionView.dequeueConfiguredReusableCell(
                            using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.title })
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
    
    //새로운 구성 레이아웃 반환
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
