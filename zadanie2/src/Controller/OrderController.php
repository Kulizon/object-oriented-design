<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\Product;
use App\Repository\OrderRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/order')]
class OrderController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function index(OrderRepository $repository): Response
    {
        return $this->render('order/index.html.twig', [
            'orders' => $repository->findAll(),
        ]);
    }

    #[Route('/new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $em, ProductRepository $productRepository): Response
    {
        if ($request->isMethod('POST')) {
            $order = new Order();
            $order->setCustomerName($request->request->get('customer_name'));

            $productIds = $request->request->all('product_ids');
            if ($productIds) {
                foreach ($productIds as $productId) {
                    $product = $productRepository->find($productId);
                    if ($product) {
                        $order->addProduct($product);
                    }
                }
            }

            $order->recalculateTotal();

            $em->persist($order);
            $em->flush();

            return $this->redirectToRoute('app_order_index');
        }

        return $this->render('order/new.html.twig', [
            'products' => $productRepository->findAll(),
        ]);
    }

    #[Route('/{id}', methods: ['GET'], requirements: ['id' => '\d+'])]
    public function show(Order $order): Response
    {
        return $this->render('order/show.html.twig', [
            'order' => $order,
        ]);
    }

    #[Route('/{id}/edit', methods: ['GET', 'POST'], requirements: ['id' => '\d+'])]
    public function edit(Request $request, Order $order, EntityManagerInterface $em, ProductRepository $productRepository): Response
    {
        if ($request->isMethod('POST')) {
            $order->setCustomerName($request->request->get('customer_name'));
            $order->setStatus($request->request->get('status'));

            foreach ($order->getProducts()->toArray() as $product) {
                $order->removeProduct($product);
            }

            $productIds = $request->request->all('product_ids');
            if ($productIds) {
                foreach ($productIds as $productId) {
                    $product = $productRepository->find($productId);
                    if ($product) {
                        $order->addProduct($product);
                    }
                }
            }

            $order->recalculateTotal();
            $em->flush();

            return $this->redirectToRoute('app_order_index');
        }

        return $this->render('order/edit.html.twig', [
            'order' => $order,
            'products' => $productRepository->findAll(),
        ]);
    }

    #[Route('/{id}/delete', methods: ['POST'], requirements: ['id' => '\d+'])]
    public function delete(Order $order, EntityManagerInterface $em): Response
    {
        $em->remove($order);
        $em->flush();

        return $this->redirectToRoute('app_order_index');
    }
}
