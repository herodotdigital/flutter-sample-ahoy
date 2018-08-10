enum TableSectionElement {
  header, row, nothing
}

typedef TableSectionCallback<H,R,O> = O Function(TableSectionElement type, H headerData, R rowData);

class TableSection<H,R,O> {
  final H headerData;
  final List<R> rows;

  TableSection({this.headerData, this.rows});

  int itemCount() {
    return rows.length + (_hasHeader() ? 1 : 0);
  }

  bool _hasHeader() {
    return headerData != null;
  }

  O query(int index, TableSectionCallback<H,R,O> callback) {
    if (index < 0) {
      return callback(TableSectionElement.nothing, null, null);
    }
    if (_hasHeader() && index == 0) {
      return callback(TableSectionElement.header, headerData, null);
    } else {
      int shiftedIndex = _hasHeader() ? index - 1 : index;
      if (shiftedIndex < rows.length) {
        var rowData = rows[shiftedIndex];
        callback(TableSectionElement.row, null, rowData);
        return callback(TableSectionElement.row, null, rowData);
      }
    }
    return callback(TableSectionElement.nothing, null, null);
  }
}