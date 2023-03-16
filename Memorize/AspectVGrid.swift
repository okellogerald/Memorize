//
//  AspectVGrid.swift
//  Memorize
//
//  Created by MacBookPro on 15/03/2023.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: Array<Item>
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
           
            let result = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
         
            VStack {
                LazyVGrid(columns: [adaptiveGridItem(width: result.width)], spacing: 0){
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit).padding(4)
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func hasBottomPadding(index: Int, rowsCount: Int) -> Bool {
        return (index + 1) % rowsCount == 0
    }
    
    private func shouldHaveRightPadding(index: Int, rowsCount: Int) -> Bool {
        let realIndex = index + 1
        if realIndex % rowsCount == 0 { return false }
        if realIndex < rowsCount { return realIndex < rowsCount }
        
        let remainder = realIndex % rowsCount
        let indexColumn = (realIndex  - remainder) / rowsCount
        let numberInRow = realIndex - (rowsCount * indexColumn)
      
        return numberInRow < rowsCount
    }
   
    /// Returns a width for making each item in the grid appear on the screen.
    /// Thus there won't be a need for scrolling to see other items.
    /// It also returns a total number of rows and columns in the grid
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> (width: CGFloat, rowsCount: Int ,columnsCount: Int) {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
    
        return (floor(size.width / CGFloat(columnCount)), rowCount, columnCount)
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
