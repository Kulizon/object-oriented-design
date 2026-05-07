<?php

namespace App\Controller;

use App\Entity\Product;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/product')]
class ProductApiController extends AbstractController
{
    private const ROUTE_ID = '/{id}';
    private const ID_REQUIREMENT = ['id' => '\d+'];

    #[Route('', methods: ['GET'])]
    public function index(ProductRepository $repository): JsonResponse
    {
        $products = $repository->findAll();
        $data = array_map(fn(Product $p) => $p->toArray(), $products);
        return $this->json($data);
    }

    #[Route(self::ROUTE_ID, methods: ['GET'], requirements: self::ID_REQUIREMENT)]
    public function show(Product $product): JsonResponse
    {
        return $this->json($product->toArray());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $product = new Product();
        $product->setName($data['name'] ?? '');
        $product->setDescription($data['description'] ?? null);
        $product->setPrice($data['price'] ?? 0);

        if (isset($data['category_id'])) {
            $category = $em->getRepository(\App\Entity\Category::class)->find($data['category_id']);
            $product->setCategory($category);
        }

        $em->persist($product);
        $em->flush();

        return $this->json($product->toArray(), Response::HTTP_CREATED);
    }

    #[Route(self::ROUTE_ID, methods: ['PUT'], requirements: self::ID_REQUIREMENT)]
    public function update(Request $request, Product $product, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (isset($data['name'])) {
            $product->setName($data['name']);
        }
        if (array_key_exists('description', $data)) {
            $product->setDescription($data['description']);
        }
        if (isset($data['price'])) {
            $product->setPrice($data['price']);
        }
        if (isset($data['category_id'])) {
            $category = $em->getRepository(\App\Entity\Category::class)->find($data['category_id']);
            $product->setCategory($category);
        }

        $em->flush();

        return $this->json($product->toArray());
    }

    #[Route(self::ROUTE_ID, methods: ['DELETE'], requirements: self::ID_REQUIREMENT)]
    public function delete(Product $product, EntityManagerInterface $em): JsonResponse
    {
        $em->remove($product);
        $em->flush();

        return $this->json(['message' => 'Product deleted']);
    }
}
