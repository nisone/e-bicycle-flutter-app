class PaginationMetaModel {
  final int currentPage;
  final int totalPages;
  final int perPage;
  final int total;
  final String sortBy;
  final String sortDir;

  PaginationMetaModel(this.currentPage, this.totalPages, this.perPage,
      this.total, this.sortBy, this.sortDir);

  factory PaginationMetaModel.fromMap(Map<String, dynamic> data) {
    return PaginationMetaModel(
      data['current_page'],
      data['total_pages'],
      data['per_page'],
      data['total'],
      data['sort_by'],
      data['sort_dir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'per_page': perPage,
      'total': total,
      'sort_by': sortBy,
      'sort_dir': sortDir
    };
  }
}
