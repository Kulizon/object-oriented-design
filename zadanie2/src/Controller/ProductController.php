<?php

namespace App\Controller;

use App\Entity\Product;
use App\Entity\Category;
use App\Repository\ProductRepository;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/product')]
class ProductController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function index(ProductRepository $repository): Response
    {
        return $this->render('product/index.html.twig', [
            'products' => $repository->findAll(),
        ]);
    }

    #[Route('/new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $em, CategoryRepository $categoryRepository): Response
    {
        if ($request->isMethod('POST')) {
            $product = new Product();
            $product->setName($request->request->get('name'));
            $product->setDescription($request->request->get('description'));
            $product->setPrice((float)$request->request->get('price'));

            $categoryId = $request->request->get('category_id');
            if ($categoryId) {
                $category = $categoryRepository->find($categoryId);
                $product->setCategory($category);
            }

            $em->persist($product);
            $em->flush();

            return $this->redirectToRoute('app_product_index');
        }

        return $this->render('product/new.html.twig', [
            'categories' => $categoryRepository->findAll(),
        ]);
    }

    #[Route('/{id}', methods: ['GET'], requirements: ['id' => '\d+'])]
    public function show(Product $product): Response
    {
        return $this->render('product/show.html.twig', [
            'product' => $product,
        ]);
    }

    #[Route('/{id}/edit', methods: ['GET', 'POST'], requirements: ['id' => '\d+'])]
    public function edit(Request $request, Product $product, EntityManagerInterface $em, CategoryRepository $categoryRepository): Response
    {
        if ($request->isMethod('POST')) {
            $product->setName($request->request->get('name'));
            $product->setDescription($request->request->get('description'));
            $product->setPrice((float)$request->request->get('price'));

            $categoryId = $request->request->get('category_id');
            if ($categoryId) {
                $category = $categoryRepository->find($categoryId);
                $product->setCategory($category);
            } else {
                $product->setCategory(null);
            }

            $em->flush();

            return $this->redirectToRoute('app_product_index');
        }

        return $this->render('product/edit.html.twig', [
            'product' => $product,
            'categories' => $categoryRepository->findAll(),
        ]);
    }

    #[Route('/{id}/delete', methods: ['POST'], requirements: ['id' => '\d+'])]
    public function delete(Product $product, EntityManagerInterface $em): Response
    {
        $em->remove($product);
        $em->flush();

        return $this->redirectToRoute('app_product_index');
    }
}
