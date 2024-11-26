import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:perpustakaan/insert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  //Buat variabel untuk menyimppan daftar buku
  List<Map<String, dynamic>> Buku = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  //fungsi untuk mengambil data buku dari supabase
  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.from('Buku').select();

    setState(() {
      Buku = List<Map<String, dynamic>>.from(response);
    });
  }

  // Fungsi untuk menambahkan Buku baru
  Future<void> addBook(String title, String author, String description) async {
    final response = await Supabase.instance.client
        .from('Buku')
        .insert({'judul': title, 'penulis': author, 'deskripsi': description});

    if (response.error == null) {
      // Menambahkan Buku yang baru ke dalam daftar Buku
      setState(() {
        Buku.add({
          'judul': title,
          'penulis': author,
          'deskripsi': description,
        });
      });

      // Tampilkan pesan berhasil (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buku berhasil ditambahkan')),
      );
    } else {
      // Tampilkan pesan error (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan buku: ${response.error}')),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Buku',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.lime.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: fetchBooks,
          ),
        ],
      ),
      body: Buku.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: Buku.length,
              itemBuilder: (context, index) {
                final book = Buku[index];
                //menampilkan card setiap data
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Card(
                    elevation: 4.0,
                    color: Colors.lime.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Colors.lime.shade900,
                        size: 40,
                      ),
                      title: Text(book['judul'] ?? 'No Judul',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book['penulis'] ?? 'No Penulis',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 10)),
                          Text(book['deskripsi'] ?? 'No Deskripsi',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Tombol edit
                          IconButton(
                              icon: const Icon(Icons.edit, color: Colors.black),
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              }),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
                //tutup card
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman untuk menambah buku baru
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(
                onAddBook: (title, author, description) {
                  addBook(title, author, description);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        backgroundColor: Colors.lime.shade900,
        child: const Icon(Icons.add),
      ),
    );
  }
}