import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/bloc/surah/bloc.dart';
import 'package:quran_app/bloc/surah/repository.dart';
import 'package:quran_app/ui/quran/component/detail_surah.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final SurahBloc surahBloc = SurahBloc(SurahRepository());

  @override
  void initState() {
    surahBloc.add(SurahFetch());
    super.initState();
  }

  @override
  void dispose() {
    surahBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
      bloc: surahBloc,
      builder: (context, state) {
        if (state is SurahFailure) {
          return Center(
            child: Text(
              '${state.dataError}',
              style: GoogleFonts.roboto(
                fontSize: 18,
              ),
            ),
          );
        }
        if (state is SurahLoaded) {
          return RefreshIndicator(
            color: const Color(0xFF332885),
            onRefresh: () async {
              surahBloc.add(SurahFetch());
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                // thickness: 1,
                endIndent: 26,
                indent: 26,
              ),
              itemCount: state.dataList?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailSurahPage(
                                  data: state.dataList?[index],
                                  dataList: state.dataList,
                                  index: index,
                                )));
                  },
                  leading: Stack(
                    children: [
                      Image.asset(
                        'assets/label_surah.png',
                        width: 36,
                        height: 36,
                      ),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Center(
                          child: Text(
                            '${state.dataList?[index].nomor}',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF332885),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    '${state.dataList?[index].namaLatin}',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color(0xFF332885),
                    ),
                  ),
                  subtitle: Text(
                    '${state.dataList?[index].tempatTurun} - ${state.dataList?[index].arti} - ${state.dataList?[index].jumlahAyat} Ayat',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Text(
                    '${state.dataList?[index].nama}',
                    style: GoogleFonts.amiri(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: const Color(0xFF332885),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF332885),
          ),
        );
      },
    );
  }
}