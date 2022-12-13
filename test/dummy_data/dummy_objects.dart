import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/data/models/tvseries/season_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_detail_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_table.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);


final testTvSeries = TvSeries(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    genreIds: [18],
    id: 11250,
    name: "Pasión de gavilanes",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 3645.173,
    posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
    voteAverage: 7.6,
    voteCount: 1765
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  genres: [Genre(id: 1, name: 'Action')],
  seasons: [],
  adult: false,
  backdropPath: 'backdropPath',
  homepage: '',
  id: 1,
  inProduction: false,
  name: 'name',
  numberOfEpisodes: 0,
  numberOfSeasons: 0,
  originalLanguage: '',
  originalName: '',
  overview: 'overview',
  popularity: 0.0,
  posterPath: 'posterPath',
  status: "",
  tagline: '',
  type: '',
  voteAverage: 0,
  voteCount: 0,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTvCache = TvSeriesTable(
  id: 1396,
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  posterPath: "/ggFHVNu6YYI5L9pCfOacjizRGt.jpg",
  name: "Breaking Bad",
);

final testTvCacheMap = {
  'id': 1396,
  'overview':
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  'posterPath': '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  'name': 'Breaking Bad',
};

final testTvDetailResponse = TvDetailResponseModel(
  seasons: [
    TvSeasonModel(
      id: 3627, 
      episodeCount: 64, 
      name: 'Specials',
      overview: '' , 
      posterPath: '/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg', 
      seasonNumber: 0
    ), 
    TvSeasonModel(
      id: 3624, 
      episodeCount: 10, 
      name: 'Season 1', 
      overview: "Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.", 
      posterPath: '/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg', 
      seasonNumber: 1
    ), 
    TvSeasonModel(
      id: 3625, 
      episodeCount: 10, 
      name: 'Season 2', 
      overview: "The cold winds of winter are rising in Westeros...war is coming...and five kings continue their savage quest for control of the all-powerful Iron Throne. With winter fast approaching, the coveted Iron Throne is occupied by the cruel Joffrey, counseled by his conniving mother Cersei and uncle Tyrion. But the Lannister hold on the Throne is under assault on many fronts. Meanwhile, a new leader is rising among the wildings outside the Great Wall, adding new perils for Jon Snow and the order of the Night's Watch.",
      posterPath: '/5tuhCkqPOT20XPwwi9NhFnC1g9R.jpg', 
      seasonNumber: 2
    ), 
    TvSeasonModel(
      id: 3626, 
      episodeCount: 10, 
      name: "Season 3", 
      overview: "Duplicity and treachery...nobility and honor...conquest and triumph...and, of course, dragons. In Season 3, family and loyalty are the overarching themes as many critical storylines from the first two seasons come to a brutal head. Meanwhile, the Lannisters maintain their hold on King's Landing, though stirrings in the North threaten to alter the balance of power; Robb Stark, King of the North, faces a major calamity as he tries to build on his victories; a massive army of wildlings led by Mance Rayder march for the Wall; and Daenerys Targaryen--reunited with her dragons--attempts to raise an army in her quest for the Iron Throne.", 
      posterPath: '/7d3vRgbmnrRQ39Qmzd66bQyY7Is.jpg', 
      seasonNumber: 3
    ), 
    TvSeasonModel(
      id: 3628,
      episodeCount: 10, 
      name: 'Season 4', 
      overview: "The War of the Five Kings is drawing to a close, but new intrigues and plots are in motion, and the surviving factions must contend with enemies not only outside their ranks, but within.", 
      posterPath: '/dniQ7zw3mbLJkd1U0gdFEh4b24O.jpg', 
      seasonNumber: 4
    ), 
    TvSeasonModel(
      id: 62090, 
      episodeCount: 10, 
      name: 'Season 5', 
      overview: "The War of the Five Kings, once thought to be drawing to a close, is instead entering a new and more chaotic phase. Westeros is on the brink of collapse, and many are seizing what they can while the realm implodes, like a corpse making a feast for crows.", 
      posterPath: '/527sR9hNDcgVDKNUE3QYra95vP5.jpg', 
      seasonNumber: 5
    ), 
    TvSeasonModel(
      id: 71881, 
      episodeCount: 10, 
      name: 'Season 6', 
      overview: "Following the shocking developments at the conclusion of season five, survivors from all parts of Westeros and Essos regroup to press forward, inexorably, towards their uncertain individual fates. Familiar faces will forge new alliances to bolster their strategic chances at survival, while new characters will emerge to challenge the balance of power in the east, west, north and south.", 
      posterPath: '/zvYrzLMfPIenxoq2jFY4eExbRv8.jpg', 
      seasonNumber: 6
    ), 
    TvSeasonModel(
      id: 81266, 
      episodeCount: 7, 
      name: 'Season 7', 
      overview: "The long winter is here. And with it comes a convergence of armies and attitudes that have been brewing for years.", 
      posterPath: '/3dqzU3F3dZpAripEx9kRnijXbOj.jpg', 
      seasonNumber: 7
    ), 
    TvSeasonModel(
      id: 107971, 
      episodeCount: 6, 
      name: 'Season 8', 
      overview: "The Great War has come, the Wall has fallen and the Night King's army of the dead marches towards Westeros. The end is here, but who will take the Iron Throne?", 
      posterPath: '/39FHkTLnNMjMVXdIDwZN8SxYqD6.jpg', 
      seasonNumber: 8
    )
  ],
  adult: false,
  backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
  firstAirDate: '2011-04-17',
  genres: [GenreModel(id: 10765, name: 'Sci-Fi & Fantasy')],
  homepage: 'http://www.hbo.com/game-of-thrones',
  id: 1399,
  inProduction: false,
  lastAirDate: '2019-05-19',
  name: 'Game of Thrones',
  nextEpisodeToAir: false,
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalLanguage: 'en',
  originalName: 'Game of Thrones',
  overview: "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  popularity: 369.594,
  posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  status: 'Ended',
  tagline: 'Winter Is Coming', 
  type: 'script', 
  voteAverage: 8.3, 
  voteCount: 11504,
);

final testTvDetailResponseMap = {
  'seasons': [
    {
      'episode_count': 64,
      'id': 3627,
      'name': 'Specials',
      'overview': '',
      'poster_path': '/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg',
      'season_number': 0
    },
    {
      'episode_count': 10,
      'id': 3624,
      'name': 'Season 1',
      'overview': 'Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros\' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.',
      'poster_path': '/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg',
      'season_number': 1
    },
    {
      'episode_count': 10,
      'id': 3625,
      'name': 'Season 2',
      'overview': 'The cold winds of winter are rising in Westeros...war is coming...and five kings continue their savage quest for control of the all-powerful Iron Throne. With winter fast approaching, the coveted Iron Throne is occupied by the cruel Joffrey, counseled by his conniving mother Cersei and uncle Tyrion. But the Lannister hold on the Throne is under assault on many fronts. Meanwhile, a new leader is rising among the wildings outside the Great Wall, adding new perils for Jon Snow and the order of the Night\'s Watch.',
      'poster_path': '/5tuhCkqPOT20XPwwi9NhFnC1g9R.jpg',
      'season_number': 2
    },
    {
      'episode_count': 10,
      'id': 3626,
      'name': 'Season 3',
      'overview': 'Duplicity and treachery...nobility and honor...conquest and triumph...and, of course, dragons. In Season 3, family and loyalty are the overarching themes as many critical storylines from the first two seasons come to a brutal head. Meanwhile, the Lannisters maintain their hold on King\'s Landing, though stirrings in the North threaten to alter the balance of power; Robb Stark, King of the North, faces a major calamity as he tries to build on his victories; a massive army of wildlings led by Mance Rayder march for the Wall; and Daenerys Targaryen--reunited with her dragons--attempts to raise an army in her quest for the Iron Throne.',
      'poster_path': '/7d3vRgbmnrRQ39Qmzd66bQyY7Is.jpg',
      'season_number': 3
    },
    {
      'episode_count': 10,
      'id': 3628,
      'name': 'Season 4',
      'overview': 'The War of the Five Kings is drawing to a close, but new intrigues and plots are in motion, and the surviving factions must contend with enemies not only outside their ranks, but within.',
      'poster_path': '/dniQ7zw3mbLJkd1U0gdFEh4b24O.jpg',
      'season_number': 4
    },
    {
      'episode_count': 10,
      'id': 62090,
      'name': 'Season 5',
      'overview': 'The War of the Five Kings, once thought to be drawing to a close, is instead entering a new and more chaotic phase. Westeros is on the brink of collapse, and many are seizing what they can while the realm implodes, like a corpse making a feast for crows.',
      'poster_path': '/527sR9hNDcgVDKNUE3QYra95vP5.jpg',
      'season_number': 5
    },
    {
      'episode_count': 10,
      'id': 71881,
      'name': 'Season 6',
      'overview': 'Following the shocking developments at the conclusion of season five, survivors from all parts of Westeros and Essos regroup to press forward, inexorably, towards their uncertain individual fates. Familiar faces will forge new alliances to bolster their strategic chances at survival, while new characters will emerge to challenge the balance of power in the east, west, north and south.',
      'poster_path': '/zvYrzLMfPIenxoq2jFY4eExbRv8.jpg',
      'season_number': 6
    },
    {
      'episode_count': 7,
      'id': 81266,
      'name': 'Season 7',
      'overview': 'The long winter is here. And with it comes a convergence of armies and attitudes that have been brewing for years.',
      'poster_path': '/3dqzU3F3dZpAripEx9kRnijXbOj.jpg',
      'season_number': 7
    },
    {
      'episode_count': 6,
      'id': 107971,
      'name': 'Season 8',
      'overview': 'The Great War has come, the Wall has fallen and the Night King\'s army of the dead marches towards Westeros. The end is here, but who will take the Iron Throne?',
      'poster_path': '/39FHkTLnNMjMVXdIDwZN8SxYqD6.jpg',
      'season_number': 8
    }
  ],
  'genres': [{'id': 10765, 'name': 'Sci-Fi & Fantasy'}],
  'adult': false,
  'backdrop_path': '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
  'first_air_date': '2011-04-17',
  'homepage': 'http://www.hbo.com/game-of-thrones',
  'id': 1399,
  'in_production': false,
  'last_air_date': '2019-05-19',
  'name': 'Game of Thrones',
  'next_episode_to_air': false,
  'number_of_episodes': 73,
  'number_of_seasons': 8,
  'original_language': 'en',
  'original_name': 'Game of Thrones',
  'overview': 'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  'popularity': 369.594,
  'poster_path': '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  'status': 'Ended',
  'tagline': 'Winter Is Coming',
  'type': 'script',
  'vote_average': 8.3,
  'vote_count': 11504          
};


