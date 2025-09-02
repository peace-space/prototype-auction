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

class PrivateAuctionListAdminEvent implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $private_auction_data;

    /**
     * Create a new event instance.
     */
    public function __construct($private_auction_data)
    {
        $this->private_auction_data = $private_auction_data;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
    public function broadcastOn(): array
    {
        return [
            new Channel('PrivateAuctionListAdmin'),
        ];
    }

    public function broadcastWith() {
        return [
            'status' => 1,
            'message' => "Successfully",
            'data' => $this->private_auction_data
        ];
    }
}
