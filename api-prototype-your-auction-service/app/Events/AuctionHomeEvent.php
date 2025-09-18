<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AuctionHomeEvent implements ShouldBroadcastNow
{
	use Dispatchable, InteractsWithSockets, SerializesModels;

	public $auction_data;
    public $has_data;

	/**
	 *      * Create a new event instance.
	 *           */
	public function __construct($has_data, $auction_data)
	{
		$this->auction_data = $auction_data;
        $this->has_data = $has_data;
	}

	/**
	 *      * Get the channels the event should broadcast on.
	 *           *
	 *                * @return array<int, \Illuminate\Broadcasting\Channel>
	 *                     */
	public function broadcastOn(): array
	{
		return [
			new Channel('AuctionList'),
		];
	}

	public function broadcastWith() {
		return [
			'status' => 1,
			'message' => 'Successfully',
            'hasData' => $this->has_data,
			'data' => $this->auction_data
		];
	}
}

