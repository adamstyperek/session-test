<?php

namespace App\Repository;

use App\Entity\Movie;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class MovieRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Movie::class);
    }

    public function findByGenre(string $genre): array
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.genre = :genre')
            ->setParameter('genre', $genre)
            ->orderBy('m.rating', 'DESC')
            ->getQuery()
            ->getResult();
    }

    public function findTopRated(int $limit = 10): array
    {
        return $this->createQueryBuilder('m')
            ->orderBy('m.rating', 'DESC')
            ->setMaxResults($limit)
            ->getQuery()
            ->getResult();
    }

    public function findByYearRange(int $startYear, int $endYear): array
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.releaseYear BETWEEN :start AND :end')
            ->setParameter('start', $startYear)
            ->setParameter('end', $endYear)
            ->orderBy('m.releaseYear', 'DESC')
            ->getQuery()
            ->getResult();
    }
} 